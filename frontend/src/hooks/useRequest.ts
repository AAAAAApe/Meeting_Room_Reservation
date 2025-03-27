/**
 * @deprecated 该Hook在此项目中已被弃用，请使用 vue-hooks-plus 的 useRequest
 * API请求Hook
 * 用于封装API请求，提供加载状态管理、错误处理和数据缓存功能
 * 简化异步请求的使用，使组件代码更加简洁和可维护
 */
import { ref } from 'vue';
import type { Ref } from 'vue';
import { ElMessage } from 'element-plus';
import type { AxiosResponse } from 'axios';

/**
 * @deprecated 该Hook在此项目中已被弃用，请使用 vue-hooks-plus 的 useRequest
 * useRequest Hook返回值类型
 * @template T 响应数据类型
 * @template P 请求参数类型数组
 */
interface UseRequestReturn<T, P extends any[]> {
  /** 响应数据，初始值为null或defaultValue */
  data: Ref<T | null>; 
  /** 加载状态，true表示请求进行中，false表示请求完成 */
  loading: Ref<boolean>; 
  /** 错误信息，请求成功时为null，失败时包含错误信息 */
  error: Ref<Error | null>; 
  /** 
   * 执行请求方法，可以随时调用此方法发起请求
   * @param params 请求参数，会传递给requestFn
   * @returns 请求成功返回响应数据，失败返回null
   */
  run: (...params: P) => Promise<T | null>; 
}

/**
 * @deprecated 该Hook在此项目中已被弃用，请使用 vue-hooks-plus 的 useRequest
 * API请求Hook，用于简化API调用并提供加载状态和错误处理
 * 
 * @template T 响应数据类型
 * @template P 请求参数类型数组
 * 
 * @param requestFn API请求函数，接收参数并返回AxiosResponse<T>的Promise
 * @param options 配置选项对象
 * @param options.defaultValue 默认数据值，在请求完成前data的初始值，默认为null
 * @param options.immediate 是否在Hook初始化时立即执行请求，默认为false
 * @param options.initialParams 初始请求参数，当immediate为true时使用，默认为空数组
 * @param options.showErrorMessage 是否显示错误提示，默认为true
 * @param options.onSuccess 请求成功回调函数，可用于执行额外的数据处理逻辑
 * 
 * @returns {UseRequestReturn<T, P>} 包含data、loading、error和run方法的对象
 * 
 * @example
 * // 新方案用法（推荐）
 * import { useRequest } from 'vue-hooks-plus';
 * const { data, loading, error, run } = useRequest(api.getUsers);
 * 
 * @example
 * // 立即执行并设置默认值
 * import { useRequest } from 'vue-hooks-plus';
 * const { data, loading, error } = useRequest(api.getUsers, {
 *   defaultParams: [{ page: 1 }],
 *   manual: false,
 *   onSuccess: (data) => console.log('请求成功', data)
 * });
 */
export default function useRequest<T, P extends any[]>(
  requestFn: (...args: P) => Promise<AxiosResponse<T>>,
  {
    defaultValue = null,
    immediate = false,
    initialParams = [] as unknown as P,
    showErrorMessage = true,
    onSuccess = undefined
  }: {
    defaultValue?: T | null;
    immediate?: boolean;
    initialParams?: P;
    showErrorMessage?: boolean;
    onSuccess?: (data: T) => void;
  } = {}
): UseRequestReturn<T, P> {
  const data = ref<T | null>(defaultValue) as Ref<T | null>;
  const loading = ref<boolean>(false);
  const error = ref<Error | null>(null);

  /**
   * 执行请求方法
   * 设置loading状态，执行请求，处理响应数据和错误
   * 
   * @param params 请求参数，会直接传递给requestFn
   * @returns 请求成功返回响应数据，失败返回null
   */
  const run = async (...params: P): Promise<T | null> => {
    loading.value = true;
    error.value = null;

    try {
      // 调用API请求函数并等待响应
      const response = await requestFn(...params);
      // 提取响应数据
      const responseData = response.data;

      if (response.status === 200) {
        // 请求成功，更新data值
        data.value = responseData;
        // 如果有成功回调函数，则执行
        if (onSuccess && responseData) {
          onSuccess(responseData);
        }
        return responseData;
      } else {
        // 业务错误处理（非200状态码）
        const errorMsg = response.statusText || '请求失败';
        error.value = new Error(errorMsg);

        // 根据配置决定是否显示错误消息
        if (showErrorMessage) {
          ElMessage.error(errorMsg);
        }
        return null;
      }
    } catch (err) {
      // 捕获网络错误或其他异常
      // 注意：大部分HTTP错误已经由axios拦截器处理，这里处理其他未捕获的错误
      const errorMsg = err instanceof Error ? err.message : '请求失败';
      // 设置错误状态
      error.value = err instanceof Error ? err : new Error(errorMsg);
      // 请求失败返回null
      return null;
    } finally {
      // 无论请求成功或失败，都将loading状态设为false
      loading.value = false;
    }
  };

  // 如果配置了immediate为true，则在Hook初始化时立即执行请求
  if (immediate) {
    // 使用initialParams作为请求参数
    run(...initialParams);
  }

  // 返回包含响应数据、加载状态、错误信息和执行方法的对象
  return {
    data,    // 响应数据ref
    loading, // 加载状态ref
    error,   // 错误信息ref
    run      // 执行请求方法
  };
}