package gdqy.edu.cn.modle;

public class Material
{
  private String id;
  private String name;
  private String unit_price;
  private String standard;
  private String unit;
  private String provider;
  private String remark;
  private String category_id;
  private String category_name;

  public String getId()
  {
    return this.id; }

  public void setId(String id) {
    this.id = id; }

  public String getName() {
    return this.name; }

  public void setName(String name) {
    this.name = name; }

  public String getUnit_price() {
    return this.unit_price; }

  public void setUnit_price(String unit_price) {
    this.unit_price = unit_price; }

  public String getStandard() {
    return this.standard; }

  public void setStandard(String standard) {
    this.standard = standard; }

  public String getUnit() {
    return this.unit; }

  public void setUnit(String unit) {
    this.unit = unit; }

  public String getProvider() {
    return this.provider; }

  public void setProvider(String provider) {
    this.provider = provider; }

  public String getRemark() {
    return this.remark; }

  public void setRemark(String remark) {
    this.remark = remark; }

  public String getCategory_id() {
    return this.category_id; }

  public void setCategory_id(String category_id) {
    this.category_id = category_id; }

  public String getCategory_name() {
    return this.category_name; }

  public void setCategory_name(String category_name) {
    this.category_name = category_name;
  }
}