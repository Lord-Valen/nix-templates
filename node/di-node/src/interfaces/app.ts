import { injectable } from "inversify";

@injectable()
export abstract class IAppService {
    async run(): Promise<void> { }
}
