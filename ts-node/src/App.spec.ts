import { App } from "./App";

describe("Hello", () => {
    let sut: App;

    beforeEach(() => {
        sut = new App();
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
