import { Injectable } from '@angular/core';
import { Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { UserService, Global, Estatus } from '../imports';

@Injectable()
export class AuthGuard implements CanActivate {

    //----------------CONSTRUCTOR------------------

    constructor(private router: Router, private userService: UserService) { }

    //----------------METHODS-------------------

    canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): boolean {
        if (state.url == '/taskManagement/login') {
            if (localStorage.getItem(Global.CurrentUser) == null)
                return true;
            this.userService.navigateToMatchPage();
            return false;
        }
        if (route.url[0].path == 'manager') {
            let status = +localStorage.getItem(JSON.parse(localStorage.getItem(Global.CurrentUser)).StatusId);
            if (status == Estatus.MANAGER)
                return true;
            this.userService.navigateToMatchPage();
            return false;
        }
        if (route.url[0].path == 'teamLeader') {
            let status=+localStorage.getItem(JSON.parse(localStorage.getItem(Global.CurrentUser)).StatusId);
            if (status == Estatus.TEAMLEADER)
                return true;
            this.userService.navigateToMatchPage();
            return false;
        }
        if (route.url[0].path == 'worker') {
            let status=+localStorage.getItem(JSON.parse(localStorage.getItem(Global.CurrentUser)).StatusId);
            if (status != Estatus.MANAGER && status != Estatus.TEAMLEADER)
               return true;
            this.userService.navigateToMatchPage();
            return false;
        }
    }

}
