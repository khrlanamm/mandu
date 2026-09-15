import {onCall, type CallableOptions, type CallableRequest} from "firebase-functions/v2/https";
import {toHttpsError} from "./errors";

/** Callable dengan penanganan error seragam (AppError → HttpsError, sisanya "internal"). */
export function callable<Result>(
  name: string,
  handler: (request: CallableRequest) => Promise<Result>,
  options: CallableOptions = {},
) {
  return onCall(options, async (request) => {
    try {
      return await handler(request);
    } catch (error) {
      throw toHttpsError(error, name);
    }
  });
}
