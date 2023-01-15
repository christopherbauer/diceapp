import { Roller } from "../Roller";
import { sumOutcomes } from "..";
import { DefinitionRoller } from ".";
import { describe, it, expect } from "@jest/globals";
import { IRandomizer, Randomizer } from "../Randomizer";

describe("DefinitionRoller", () => {
	it("Rolls die definition effectively: 1+1", () => {
		const roller = new DefinitionRoller(new Roller(new Randomizer()));
		const outcomes = roller.roll(["1+1"]);
		expect(sumOutcomes(outcomes)).toEqual(2);
	});
	it("Rolls die definition effectively: 1d4", () => {
		const randomizer: () => IRandomizer = () => ({
			getRandom: (min, max) => 4,
		});

		const roller = new DefinitionRoller(new Roller(randomizer()));
		const outcomes = roller.roll(["1d4"]);
		expect(sumOutcomes(outcomes)).toEqual(4);
	});
	it("Rolls die definition effectively: 1d4+1d4", () => {
		const randomizer: () => IRandomizer = () => ({
			getRandom: (min, max) => 4,
		});

		const roller = new DefinitionRoller(new Roller(randomizer()));
		const outcomes = roller.roll(["1d4+1d4"]);
		expect(sumOutcomes(outcomes)).toEqual(8);
	});
	it("Rolls die definition effectively: 1d8+1d8+1", () => {
		const randomizer: () => IRandomizer = () => ({
			getRandom: (min, max) => 6,
		});

		const roller = new DefinitionRoller(new Roller(randomizer()));
		const outcomes = roller.roll(["1d8+1d8+1"]);
		expect(sumOutcomes(outcomes)).toEqual(13);
	});
	it("Rolls die definition effectively: 1d8+1d8-1d4", () => {
		const randomizer: () => IRandomizer = () => ({
			getRandom: (min, max) => 3,
		});

		const roller = new DefinitionRoller(new Roller(randomizer()));
		const outcomes = roller.roll(["1d8+1d8-1d4"]);
		expect(sumOutcomes(outcomes)).toEqual(3);
	});
	it("Rolls die definition effectively: 3d8", () => {
		const randomizer: () => IRandomizer = () => ({
			getRandom: (min, max) => 3,
		});

		const roller = new DefinitionRoller(new Roller(randomizer()));
		const outcomes = roller.roll(["3d8"]);
		expect(sumOutcomes(outcomes)).toEqual(9);
	});
});
