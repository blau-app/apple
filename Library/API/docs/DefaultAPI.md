# DefaultAPI

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v1GetTokenBundlesPost**](DefaultAPI.md#v1gettokenbundlespost) | **POST** /v1/getTokenBundles | 


# **v1GetTokenBundlesPost**
```swift
    open class func v1GetTokenBundlesPost(v1GetTokenBundlesPostRequest: V1GetTokenBundlesPostRequest? = nil, completion: @escaping (_ data: V1GetTokenBundlesPost200Response?, _ error: Error?) -> Void)
```



Get Token Bundles

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let v1GetTokenBundlesPostRequest = _v1_getTokenBundles_post_request(evmPublicKeys: ["evmPublicKeys_example"]) // V1GetTokenBundlesPostRequest |  (optional)

DefaultAPI.v1GetTokenBundlesPost(v1GetTokenBundlesPostRequest: v1GetTokenBundlesPostRequest) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **v1GetTokenBundlesPostRequest** | [**V1GetTokenBundlesPostRequest**](V1GetTokenBundlesPostRequest.md) |  | [optional] 

### Return type

[**V1GetTokenBundlesPost200Response**](V1GetTokenBundlesPost200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

