import { injectable } from "inversify";
import { IAppService } from "./interfaces";

@injectable()
export class AppService extends IAppService {
    async run(): Promise<void> {
        const message: string = "Hello, World!";

        console.log(message);
    }
}
