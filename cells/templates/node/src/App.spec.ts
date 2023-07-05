import "reflect-metadata";

import { Container } from "inversify";
import { bindings } from "./bindings.js";
import { IApp } from "./interfaces.js";

describe("Hello", () => {
  let container: Container;
  let sut: IApp;

  beforeAll(() => {
    container = new Container();
    container.load(bindings);
    sut = container.get(IApp);
  });

  beforeEach(() => {
    container.snapshot();
  });

  afterEach(() => {
    container.restore();
  });

  it("is defined", () => {
    expect(sut).toBeDefined();
  });

  it("says hello", () => {
    const consoleSpy = vi.spyOn(console, "log");

    sut.run();

    expect(consoleSpy).toHaveBeenCalledWith("Hello, World!");
  });
});
