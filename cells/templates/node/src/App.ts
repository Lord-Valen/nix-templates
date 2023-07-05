import { provide } from "inversify-binding-decorators";
import { IApp } from "./interfaces.js";

@provide(IApp)
export class App {
  public async run(): Promise<void> {
    const message: string = "Hello, World!";

    console.log(message);
  }
}
