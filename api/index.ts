import express, { json } from "express";
import { config } from "dotenv";
import { errorHandler, requestLogHandler } from "./lib/middlewares";
import logger from "./lib/logger";
import { rollRouter } from "./routes";
const app = express();

const parsedEnvironment = config();
logger.info(parsedEnvironment);
app.use(requestLogHandler);

//health check endpoint
app.get("/", json(), (request, response) => {
	response.status(200).send({
		live: true,
	});
});

app.use("/rolls", rollRouter);

//If the requested route is not otherwise handled
app.all("*", async (_request, _result) => {
	throw new Error("Route not found");
});
app.use(errorHandler);
const start = async () => {
	const port = Number(process.env.PORT);
	app.listen(port, () => {
		console.log(`Listening on port ${port}!`);
	});
};

start();
