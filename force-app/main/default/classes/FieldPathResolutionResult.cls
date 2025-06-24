@NamespaceAccessible
public class FieldPathResolutionResult {
    @NamespaceAccessible public String apiName { get; set; }
    @NamespaceAccessible public String label { get; set; }
    @NamespaceAccessible public String objectApiName { get; set; }
    @NamespaceAccessible public Boolean isRelationship { get; set; }
    @NamespaceAccessible public String relationshipName { get; set; }
    @NamespaceAccessible public Schema.DescribeFieldResult fieldDescribe { get; set; }
}