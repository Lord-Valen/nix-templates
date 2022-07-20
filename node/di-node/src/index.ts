#! usr/bin/env node

import "reflect-metadata";
import { Container } from "inversify";
import { IAppService } from "./interfaces";
import { AppModule } from "./app.module";

async function run() {
    const container = new Container();
    container.load(new AppModule);
    const app = container.get(IAppService);
    app.run();
}

run();
