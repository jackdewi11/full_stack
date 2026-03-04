// Minimal local declaration for 'express' to satisfy TypeScript in CI
// Provides enough surface area for this project's usage (handlers, app methods, basic types).
declare namespace Express {
  export interface Request {
    headers?: any;
    body?: any;
    params?: any;
    query?: any;
    [key: string]: any;
  }

  export interface Response {
    json: (body?: any) => any;
    status: (code: number) => any;
    send: (body?: any) => any;
    [key: string]: any;
  }

  export type NextFunction = (...args: any[]) => any;

  export interface Application {
    use: (...args: any[]) => any;
    get: (...args: any[]) => any;
    post: (...args: any[]) => any;
    listen: (...args: any[]) => any;
    [key: string]: any;
  }
}

declare module "express" {
  export import Request = Express.Request;
  export import Response = Express.Response;
  export import NextFunction = Express.NextFunction;
  export import Application = Express.Application;
}

declare function express(): Express.Application;
export = express;
