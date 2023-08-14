import express, {Router} from "express";
import {TeamController} from "./features/team/team.controller";
import {TeamRepository} from "./features/team/team.repository";
import {TeamService} from "./features/team/team.service";
import {authService} from "./features/user/authentication.service";

// Creating a new router object.
const teamRouter: Router = express.Router();

// Creating a new instance of the TeamRepository class.
const teamRepository = new TeamRepository();

// Creating a new instance of the TeamService class.
const teamService = new TeamService(teamRepository);

// Creating a new instance of the TeamController class.
const teamController = new TeamController(teamService);

// Creating a new route for the teamRouter object.
teamRouter.get(
  "/teams",
  (req, res, next) => authService.verifyToken(req, res, next),
  (req, res) => teamController.getTeamByTeammateId(req, res)
);

export default teamRouter;
