/**
 * API响应类型定义文件
 * 定义了API响应的通用格式和类型
 */

/**
 * 通用API响应接口
 */
export interface ApiResponse<T = any> {
  code: number;       // 响应状态码
  message: string;    // 响应消息
  data: T;            // 响应数据
  success: boolean;   // 是否成功
}

/**
 * 分页请求参数接口
 */
export interface PageParams {
  current?: number;   // 当前页码
  size?: number;      // 每页大小
  [key: string]: any; // 其他可能的查询参数
}

/**
 * 分页响应接口
 */
export interface PageResponse<T> {
  records: T[];       // 数据记录
  total: number;      // 总记录数
  size: number;       // 每页大小
  current: number;    // 当前页码
  pages: number;      // 总页数
}

/**
 * 排序参数接口
 */
export interface SortParams {
  field: string;      // 排序字段
  order: 'asc' | 'desc'; // 排序方向
}

/**
 * 查询参数接口
 */
export interface QueryParams extends PageParams {
  sort?: SortParams;  // 排序参数
  [key: string]: any; // 其他查询参数
}