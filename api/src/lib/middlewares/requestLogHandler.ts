import { Request, Response, NextFunction } from "express";

export const requestLogHandler = (
	request: Request,
	_response: Response,
	next: NextFunction
) => {
	let { method, path } = request;

	console.log(`BEGIN REQUEST: ${method} ${path}`);
	var loggerData = JSON.parse(
		JSON.stringify({
			method: request.method,
			path: request.path,
			body: request.body,
			headers: request.headers,
			ip: request.connection.remoteAddress,
		})
	);
	console.debug(loggerData);

	next();
};
