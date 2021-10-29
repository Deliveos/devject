import {createLogger, transports, format, level} from "winston";
import config from "./config";
const {combine, colorize, timestamp, simple} = format;

// import winston from "winston";
// import config from "./config";

const logFormat = format.printf(({ level, message, timestamp }) => {
  return `[${timestamp}] [${level}]: ${message}`;
});

const logger = createLogger({
  level: config.LEVEL
});


if (process.env.NODE_ENV === 'production') {
  logger.add(new transports.Console({
    format: simple(),
  }));
}

if (process.env.NODE_ENV !== 'production') {
  logger.add(new transports.Console({
    format: combine(
      colorize(),
      timestamp({format: 'YYYY-MM-DD HH:mm:ss'}),
      logFormat,
    )
  }));
}

export {logger};