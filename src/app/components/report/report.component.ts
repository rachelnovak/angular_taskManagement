import { Component, OnInit } from '@angular/core';
import { Global, Project, ProjectFilter, ProjectService, ExcelService, ReportService } from '../../imports';

@Component({
  selector: 'app-report',
  templateUrl: './report.component.html',
  styleUrls: ['./report.component.css']
})
export class ReportComponent implements OnInit {

  //----------------PROPERTIES-------------------

  projectsReport: Project[];
  conditions: ProjectFilter;
  state: string;

  //----------------CONSTRUCTOR------------------

  constructor(
    private projectService: ProjectService,
    private excelService: ExcelService,
    private reportService: ReportService) {
    this.reportService.filterSubject.subscribe(
      (conditions: ProjectFilter) => {
        this.conditions = conditions;
      }
    )
  }

  //-----------------METHODS--------------------

  ngOnInit() {
   // this.initProjectsReport();
  }

  initProjectsReport() {
    this.projectService.getAllProjects().subscribe(
      (projects: Project[]) => {
        // this.projectService.initDates(projects)
        this.projectsReport = projects;
      },
      err => console.log(err));
  }

  exportToExcel() {
    let presenceHours: number;
    let data = this.projectsReport.map(project => {
      this.reportService.getHours(project.Id).subscribe(
        (hours: number) => {
          presenceHours = hours;
        },
        err => console.log(err));

      return {
        projectName: project.Name,
        customerName: project.Customer,
        teamLeaderName: project.TeamLeaderId,////////
        //teamLeaderEmail: project.teamLeader.email,
        startDate: project.StartDate,
        endDate: project.EndDate,
        projectHours: project.DevelopHours,
        presenceHours: presenceHours,
        toDoHours: project.DevelopHours - presenceHours,
        workingPercent: (presenceHours / project.DevelopHours) * 100 + '%'
      }
    });
    let userName: string = JSON.parse(localStorage.getItem(Global.CurrentUser)).userName;
    this.excelService.exportAsExcelFile(data, `${userName}_projects`);
  }

  openRequestForm() {
    this.state = "in";
  }

  closeRequestForm() {
    this.state = "out"
  }

}