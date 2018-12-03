import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { User, Global, Project } from '../../imports';

@Injectable()
export class ProjectService {
    //----------------PROPERTIRS-------------------

    basicURL: string = "http://localhost:53728" + '/api';
    user: User;
    idsWorkers: number[];

    //----------------CONSTRUCTOR------------------

    constructor(private httpClient: HttpClient) {
        this.user = JSON.parse(localStorage.getItem(Global.CurrentUser));
    }

    //----------------METHODS-------------------

    //PUT
    addProject(project: Project): Observable<any> {
        let url: string = `${this.basicURL}/addProject`;
        return this.httpClient.put(url, project);//+ `/${this.user.UserName}`
    }

    //GET
    getProject(projectId: number): Observable<any> {
        let url: string = `${this.basicURL}/getProject`;
        return this.httpClient.get(url + `/${projectId}`);
    }

    //PUT
    updateProject(project: Project): Observable<any> {
        let url: string = `${this.basicURL}/updateUser`;
        return this.httpClient.put(url, project);
    }

    //GET
    getAllProjects(): Observable<any> {
        let url: string = `${this.basicURL}/getAllProjects`;//TODO
        return this.httpClient.get(url);
    }

    //GET
    getAllTeamLeaderProjects(): Observable<any> {
        let url: string = `${this.basicURL}/getAllTeamLeaderProjects`;
        return this.httpClient.get(url);
    }

    //POST
    addWorkersToProject(workers: User[], name): Observable<any> {
        this.idsWorkers = [];
        workers.forEach(worker => {
            this.idsWorkers.push(worker.Id);
        });
        let url: string = `${this.basicURL}/addWorkersToProject`;
        return this.httpClient.post(url + "/" + name + "/", JSON.parse(JSON.stringify(this.idsWorkers)));
    }

    //PUT
    editProject(projectId: number, DevelopHours: number, QAHours: number, UIUXHours: number, endDate: Date,isComplete:boolean): Observable<any> {
        let url: string = `${this.basicURL}/updateProjectDetails`;
        return this.httpClient.put(url, {
            "projectId": projectId,
            "developHours": DevelopHours,
            "QAHours": QAHours,
            "UIUXHours": UIUXHours,
            "endDate": endDate,
            "isComplete":isComplete
        });
    }

}