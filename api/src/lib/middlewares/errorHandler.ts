import { Response, Request, NextFunction } from "express";

export const errorHandler = (
	err: Error,
	request: Request,
	response: Response,
	next: NextFunction
) => {
	console.error(err);
	response.status(400).send({
		errors: [{ message: err }],
	});
	next();
};
