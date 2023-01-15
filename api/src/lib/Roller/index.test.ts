import { describe, it, expect } from "@jest/globals";
import { Roller } from ".";

describe("Roller", () => {
	it("Rolls single die using static roller", () => {
		//arrange
		const roller = new Roller({
			getRandom(min, max) {
				return 1;
			},
		});

		//act
		const actual = roller.rollDie(8);

		//assert
		expect(actual).toBe(1);
	});
	it("Rolls multiple die using static roller", () => {
		//arrange
		const roller = new Roller({
			getRandom(min, max) {
				return 1;
			},
		});

		//act
		const actual = roller.rollMultipleDie(4, 8);

		//assert
		expect(actual).toStrictEqual([1, 1, 1, 1]);
	});
	it("Rolls multiple die using randomizer", () => {
		//arrange
		const predeterminedRolls = [3, 5, 2, 5];
		let rollIndex = 0;
		const roller = new Roller({
			getRandom(min, max) {
				const roll = predeterminedRolls[rollIndex];
				rollIndex++;
				return roll;
			},
		});

		//act
		const actual = roller.rollMultipleDie(4, 8);

		//assert
		expect(actual).toStrictEqual(predeterminedRolls);
	});
});
