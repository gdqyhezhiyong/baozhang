package gdqy.edu.cn.modle;

public class User
{
  private String username;
  private String name;
  private String password;
  private int role_id;
  private String address;
  private String phone_number;
  private int class_id;
  private String id;
  private String grade;
  private String departments;
  private String classes;
  private String area;

  public String getArea()
  {
    return this.area; }

  public void setArea(String area) {
    this.area = area; }

  public String getGrade() {
    return this.grade; }

  public void setGrade(String grade) {
    this.grade = grade; }

  public String getDepartments() {
    return this.departments; }

  public void setDepartments(String departments) {
    this.departments = departments; }

  public String getClasses() {
    return this.classes; }

  public void setClasses(String classes) {
    this.classes = classes; }

  public String getId() {
    return this.id; }

  public void setId(String id) {
    this.id = id; }

  public String getUsername() {
    return this.username; }

  public void setUsername(String username) {
    this.username = username; }

  public String getName() {
    return this.name; }

  public void setName(String name) {
    this.name = name; }

  public String getPassword() {
    return this.password; }

  public void setPassword(String password) {
    this.password = password; }

  public int getRole_id() {
    return this.role_id; }

  public void setRole_id(int roleId) {
    this.role_id = roleId; }

  public String getAddress() {
    return this.address; }

  public void setAddress(String address) {
    this.address = address; }

  public String getPhone_number() {
    return this.phone_number; }

  public void setPhone_number(String phoneNumber) {
    this.phone_number = phoneNumber; }

  public int getClass_id() {
    return this.class_id; }

  public void setClass_id(int classId) {
    this.class_id = classId;
  }
}