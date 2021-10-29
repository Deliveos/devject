import users from "./users.routes";
import projects from "./projects.routes";

export default (app) => {
  app.use("/api/users", users),
  app.use("/api/projects", projects)
}