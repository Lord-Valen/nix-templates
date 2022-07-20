import { ContainerModule } from "inversify";
import { AppService } from "./app";
import { IAppService } from "./interfaces";

export class AppModule extends ContainerModule {
    public constructor() {
        super((bind) => {
            bind(IAppService).to(AppService);
        })
    }
}
