import { TeammateWithDeclaration } from './teammateWithDeclaration.dtoOut';
import { TeammateRepository } from './teammate.repository';

export class TeammateService {
  teammateRepository: TeammateRepository;

  constructor(repository: TeammateRepository) {
    this.teammateRepository = repository;
  }

  getByTeamIdWithLastDeclaration = async (teammate_user_id: number) => {
    // THIS NEED TO BE CHANGED TO ALLOW A CAPTAIN TO SELECT HIS TEAM WHEN HE HANDLE SEVERAL OF THEM
    const getTeammates: any[] =
      await this.teammateRepository.getByTeamIdWithLastDeclaration(
        teammate_user_id
      );

    let result: TeammateWithDeclaration[] = [];
    getTeammates.forEach((element) => {
      result.push(
        new TeammateWithDeclaration(
          element.user_id,
          element.teammate_id,
          element.user_last_name,
          element.user_first_name,
          element.declaration_date,
          element.declaration_status,
          element.team_id,
          element.team_name,
          element.declaration_date_start,
          element.declaration_date_end,
        )
      );
    });
    return result;
  };
}
