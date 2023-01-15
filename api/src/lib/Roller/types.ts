export interface IRoller {
	rollDie: (die: number) => number;
	rollMultipleDie: (count: number, die: number) => number[];
}
