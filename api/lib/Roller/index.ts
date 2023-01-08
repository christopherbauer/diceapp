import logger from "../logger";
import { IRandomizer } from "../Randomizer";
export interface IRoller {
	rollDie: (die: number) => number;
	rollMultipleDie: (count: number, die: number) => number[];
}

export class Roller implements IRoller {
	randomizer: IRandomizer;
	constructor(randomizer: IRandomizer) {
		this.randomizer = randomizer;
	}
	rollDie = (die: number) => this.randomizer.getRandom(1, die);
	rollMultipleDie = (count: number, die: number) => {
		let rolls: number[] = [];
		logger.info(`Rolling ${count} d${die}`);
		for (let i = 0; i < count; i++) {
			rolls.push(this.rollDie(die));
		}
		return rolls;
	};
}
