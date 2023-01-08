import { describe, it, expect } from "@jest/globals";
import { Randomizer } from ".";

describe("Randomizer", () => {
	it.each([
		[0, 10000, 0, 9],
		[0, 10000, 0, 1],
		[1, 10000, 0, 1],
	])(
		"Randomly rolls %s in %p rolls of %s-%s",
		(expected, rolls, min, max) => {
			//arrange
			const randomizer = new Randomizer();

			//act
			const actual = [...new Array(rolls)].map(() =>
				randomizer.getRandom(min, max)
			);

			//assert
			const hasActual =
				actual.findIndex((value) => value === expected) !== -1;
			expect(hasActual).toBe(true);
		}
	);
});
