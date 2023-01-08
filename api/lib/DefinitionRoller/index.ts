import logger from "../logger";
import { IOutcome } from "../types";
import { IRoller } from "../Roller";

export class DefinitionRoller {
	roller: IRoller;
	constructor(roller: IRoller) {
		this.roller = roller;
	}
	roll = (rollDefs: string[]) => {
		let rollOutcomes: IOutcome[] = [];
		rollDefs.forEach((rollDef) => {
			let operations = this.getOperations(rollDef);
			operations?.forEach((operation) => {
				const isMinus = operation.startsWith("-");
				const isDieRoll = operation.indexOf("d") > -1;
				if (isDieRoll) {
					let [count, die] = operation.split("d");
					let rolls = this.roller.rollMultipleDie(
						Math.abs(parseInt(count)),
						parseInt(die)
					);

					let total = rolls.reduce((prev, cur) => (prev += cur), 0);
					logger.info(
						`${operation} = ${JSON.stringify(rolls)} = ${total}`
					);
					rollOutcomes.push({
						def: operation,
						rolls,
						total: isMinus ? -total : total,
					});
				} else {
					rollOutcomes.push({
						def: operation,
						total: parseInt(operation),
					});
				}
			});
		});
		return rollOutcomes;
	};
	getOperations = (rollDef: string) => {
		const rollRegex = /(\-*\d+d\d+)|(\-*\d+)/g;
		return rollDef.match(rollRegex);
	};
}
