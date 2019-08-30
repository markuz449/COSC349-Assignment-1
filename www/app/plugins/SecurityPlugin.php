<?php

namespace App\Plugins;

use Phalcon\Acl;
use Phalcon\Acl\Role;
use Phalcon\Acl\Resource;
use Phalcon\Events\Event;
use Phalcon\Mvc\User\Plugin;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Acl\Adapter\Memory as AclList;

class SecurityPlugin extends Plugin {

	public function getAcl() {
		if (!isset($this->persistent->acl)) {
			$acl = new AclList();

			$acl->setDefaultAction(Acl::DENY);

			// Register Roles
			$roles = [
				'users' => new Role(
					'Users',
					'Admin privileges'
				),
				'guests' => new Role(
					'Guests',
					'Anyone browsing the site'
				)
			];

			foreach ($roles as $role) {
				$acl->addRole($role);
			}

			// Private areas
			$privateResources = [
				'prices' => ['index', 'delete', 'confirm'],
				'reviews' => ['index', 'view','update', 'delete', 'feature'],
				'messages' => ['index', 'search', 'read', 'delete'],
			];

			foreach ($privateResources as $resource => $actions) {
				$acl->addResource(new Resource($resource), $actions);
			}

			//Public area resources
			$publicResources = [
				'index'      => ['index'],
				'about'      => ['index', 'privacy', 'terms'],
				'register'   => ['index'],
				'chains'   	 => ['index', 'view'],
				'review'   => ['index', 'success'],
				'write'   => ['index', 'success'],
				'error'     => ['show401', 'show404', 'show500'],
				'session'    => ['index', 'register', 'start', 'end'],
				'contact'    => ['index', 'send'],
				'rate'    => ['up', 'down']
			];
			foreach ($publicResources as $resource => $actions) {
				$acl->addResource(new Resource($resource), $actions);
			}
			//Grant access to public areas to both users and guests
			foreach ($roles as $role) {
				foreach ($publicResources as $resource => $actions) {
					foreach ($actions as $action){
						$acl->allow($role->getName(), $resource, $action);
					}
				}
			}
			//Grant access to private area to role Users
			foreach ($privateResources as $resource => $actions) {
				foreach ($actions as $action){
					$acl->allow('Users', $resource, $action);
				}
			}
			//The acl is stored in session, APC would be useful here too
			$this->persistent->acl = $acl;

		}

		return $this->persistent->acl;

	}

	public function beforeExecuteRoute(Event $event, Dispatcher $dispatcher)
	{
		$auth = $this->session->get('auth');
		if (!$auth){
			$role = 'Guests';
            $this->view->setTemplateBefore('default');
		} else {
			$role = 'Users';
            $this->view->setTemplateBefore('auth');
		}
		$controller = $dispatcher->getControllerName();
        $namespace = $dispatcher->getNamespaceName();
		if ($controller == "error" || $namespace == "App\API") {
			return true;
		}
		$action = $dispatcher->getActionName();
		$acl = $this->getAcl();
		if (!$acl->isResource($controller)) {
			$dispatcher->forward([
				'controller' => 'error',
				'action'     => 'show404'
			]);
			return false;
		}
		$allowed = $acl->isAllowed($role, $controller, $action);
		if (!$allowed) {
			$dispatcher->forward([
				'controller' => 'error',
				'action'     => 'show401'
			]);
                        $this->session->destroy();
			return false;
		}
	}
}

