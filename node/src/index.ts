#! usr/bin/env node

import "reflect-metadata";

import { Container } from "inversify";
import { IApp } from "./interfaces.js";
import { bindings } from "./bindings.js";

const container = new Container();
container.load(bindings);

const app = container.get(IApp);

app.run();
