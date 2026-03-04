// Minimal module declaration to satisfy TypeScript when @types/express are not available
// This file is a shim for CI environments where @types may not be installed.
declare module "express" {
  import type { RequestHandler, Request, Response, NextFunction } from "express-serve-static-core";
  const express: () => {
    use: (handler: RequestHandler) => any;
  };
  export = express;
}
