import { IOutcome } from "./types";

export const sumOutcomes = (outcomes: IOutcome[]) =>
	outcomes.reduce((prev, cur) => prev + cur.total, 0);
