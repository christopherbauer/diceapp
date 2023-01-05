import express, { Error, Response, Request, NextFunction } from "express";
import { config } from "dotenv";
const app = express();

const parsedEnvironment = config();
console.log(parsedEnvironment);
app.use((request: Request, response: Response, next: NextFunction) => {
	let { method, path } = request;

	//Testing GA
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
});

//If the requested route is not otherwise handled
app.all("*", async (request, result, next) => {
	throw new Error("Route not found");
});
app.use(
	(err: Error, request: Request, response: Response, next: NextFunction) => {
		console.error(err);
		response.status(400).send({
			errors: [{ message: err }],
		});
	}
);
const start = async () => {
	const port = Number(process.env.PORT);
	app.listen(port, () => {
		console.log(`Listening on port ${port}!`);
	});
};

start();
