package gdqy.edu.cn.modle;

public class Supplies
{
  private String id;
  private String name;
  private String provider;
  private String standard;
  private String number;
  private String unit_price;
  private float total;
  private String category_name;
  private String remark;
  private String material_id;
  private String bill_id;
  private String unit;

  public String getId()
  {
    return this.id; }

  public void setId(String id) {
    this.id = id; }

  public String getName() {
    return this.name; }

  public void setName(String name) {
    this.name = name; }

  public String getProvider() {
    return this.provider; }

  public void setProvider(String provider) {
    this.provider = provider; }

  public String getStandard() {
    return this.standard; }

  public void setStandard(String standard) {
    this.standard = standard; }

  public String getNumber() {
    return this.number; }

  public void setNumber(String number) {
    this.number = number; }

  public String getUnit_price() {
    return this.unit_price; }

  public void setUnit_price(String unit_price) {
    this.unit_price = unit_price; }

  public float getTotal() {
    return this.total; }

  public void setTotal(float total) {
    this.total = total;
    }

  public String getCategory_name() {
    return this.category_name; }

  public void setCategory_name(String category_name) {
    this.category_name = category_name; }

  public String getRemark() {
    return this.remark; }

  public void setRemark(String remark) {
    this.remark = remark; }

  public String getMaterial_id() {
    return this.material_id; }

  public void setMaterial_id(String material_id) {
    this.material_id = material_id; }

  public String getBill_id() {
    return this.bill_id; }

  public void setBill_id(String bill_id) {
    this.bill_id = bill_id; }

  public String getUnit() {
    return this.unit; }

  public void setUnit(String unit) {
    this.unit = unit;
  }
}