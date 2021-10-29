const config = {
  PG_USER: process.env.PG_USER,
  PG_HOST: process.env.PG_HOST,
  PG_PORT: Number(process.env.PG_PORT),
  PG_PASSWORD: process.env.PG_PASSWORD,
  PG_DATABASE: process.env.PG_DATABASE,
  SECRET: process.env.SECRET,
  LEVEL: process.env.LEVEL
};

export default config;