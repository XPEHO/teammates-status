import {Client, QueryResult} from "pg";

export class TeammateRepository {
  getByTeamIdWithLastDeclaration = async (team_id: number) => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `
    SELECT u.user_id, tm.teammate_id, u.user_last_name, u.user_first_name,
        CASE
            WHEN max_decl.declaration_date::date = now()::date
            OR (
                max_decl.declaration_date_start::date <= now()::date
                AND max_decl.declaration_date_end::date > now()::date
              )
            THEN max_decl.declaration_date
            ELSE NULL
        END AS declaration_date,
        CASE
            WHEN max_decl.declaration_date::date = now()::date
            OR (
                max_decl.declaration_date_start::date <= now()::date
                AND max_decl.declaration_date_end::date > now()::date
              )
            THEN max_decl.declaration_status
            ELSE NULL
        END AS declaration_status
        FROM public.user u
        INNER JOIN public.teammate tm
        ON u.user_id = tm.teammate_user_id
        LEFT JOIN
        (
          SELECT *
          FROM (
            SELECT declaration_user_id, declaration_date, declaration_status,declaration_date_start, declaration_date_end, rank()
            OVER (PARTITION BY declaration_user_id ORDER BY declaration_date DESC)
            FROM public.declaration
          ) t
          WHERE rank = 1
        ) as max_decl
        ON max_decl.declaration_user_id = tm.teammate_cuser_id
        WHERE tm.teammate_team_id = $1;
  `;
    client.connect();
    const poolResult: QueryResult = await client.query(query, [team_id]);
    await client.end();

    return poolResult.rows;
  };
}
