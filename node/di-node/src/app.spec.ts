import { Container } from "inversify";
import { AppModule } from "./app.module";
import { IAppService } from "./interfaces";

describe("Hello", () => {
    let container: Container;
    let sut: IAppService;

    beforeAll(() => {
        container = new Container;
        container.load(new AppModule)
        sut = container.get(IAppService);
    })

    beforeEach(() => {
        container.snapshot();
    })

    afterEach(() => {
        container.restore();
    })

    test("is defined", () => {
        expect(sut).toBeDefined()
    })

    test("says hello", () => {
        const consoleSpy = jest.spyOn(console, 'log');

        sut.run();

        expect(consoleSpy).toHaveBeenCalledWith("Hello, World!")
    })
})
