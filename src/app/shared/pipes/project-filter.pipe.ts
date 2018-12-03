import { Pipe, PipeTransform } from '@angular/core';
import { Project, ProjectFilter } from '../../imports';

@Pipe({
  name: 'projectFilter'
})
export class ProjectFilterPipe implements PipeTransform {

  transform(projects: Project[], conditions: ProjectFilter): Project[] {
    if (!projects)
      return null;
    if (!conditions)
      return projects;
    return projects.filter(project =>
      (!conditions.monthId || project.StartDate.getMonth() < conditions.monthId && project.EndDate.getMonth() >= conditions.monthId) &&
      (!conditions.workerId) &&
      (!conditions.teamLeaderId || project.TeamLeaderId == conditions.teamLeaderId) &&
      (!conditions.projectId || project.Id == conditions.projectId))
  }

}
