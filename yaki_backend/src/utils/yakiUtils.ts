export default class YakiUtils {
  /**
   * Transform a object list into a flat array containing only the objects values.
   * @param objectList
   * @returns Array<String>
   */
  static objectsListToValuesList(objectList: Array<object>): Array<string> {
    const flatValuesList = objectList
      .map((obj) => {
        return Object.values(obj);
      })
      .flat();
    return flatValuesList;
  }

  /**
   *
   * @param arr list containing all objects to insert, will determine row(s) count.
   * @param obj object to be inserted in a row, will determine values count to be saved ( columns ).
   * @param startValue query VALUES start value.
   * @returns query VALUE string : ($1, $2...), ($x, $y...),...
   */
  static queryValuesString(arr: Array<any>, obj: object, startValue: number): string {
    if (!arr || !obj) {
      throw new TypeError("data is requiered to create the query VALUES string");
    }
    // amount of object in the array ( row count )
    const objectCount: number = arr.length;
    // values count per object ( columns )
    const valuesCount: number = Object.values(obj).length;

    if (objectCount < 1 || valuesCount < 1) {
      throw new TypeError("No data to create the query VALUES string");
    }

    const rows: Array<string> = Array(objectCount).fill("0");
    const columns: Array<string> = Array(valuesCount).fill("0");

    const postgresValues = rows
      .map(() => {
        return `(${columns.map(() => `$${startValue++}`).join(", ")})`;
      })
      .join(", ");

    return postgresValues;
  }
}
