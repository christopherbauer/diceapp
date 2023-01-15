import { IRandomizer } from "./types";

export class Randomizer implements IRandomizer {
	getRandom = (min: number, max: number) =>
		Math.floor(Math.random() * (max - min + 1) + min);
}

export { IRandomizer };
