import express from "express";
import { DefinitionRoller, Roller, Randomizer, sumOutcomes } from "../lib";

const router = express.Router();

const roller = new DefinitionRoller(new Roller(new Randomizer()));

router.get("/:rollDef", (request, response) => {
	const { params } = request;
	const outcomes = roller.roll([params.rollDef]);
	response.send({ total: sumOutcomes(outcomes), rolls: outcomes });
});

export { router as rollRouter };
