class ProductModel {
  int? productId;
  String? name;
  String? imageUrl;
  String? description;
  String? sumAssured;
  String? policyTerm;
  String? mode;
  String? age;
  String? ageMax;
  String? maturityBenefit;
  String? deathBenefit;
  String? supplementaryInsuranceFacility;
  String? investment;
  String? surrenderAndInvestmentFacility;
  String? paidUpValue;
  String? incomeTaxRebateFacility;

  ProductModel(
      {this.productId,
      this.name,
      this.imageUrl,
      this.description,
      this.sumAssured,
      this.policyTerm,
      this.mode,
      this.age,
      this.ageMax,
      this.maturityBenefit,
      this.deathBenefit,
      this.supplementaryInsuranceFacility,
      this.investment,
      this.surrenderAndInvestmentFacility,
      this.paidUpValue,
      this.incomeTaxRebateFacility});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    sumAssured = json['sum_assured'];
    policyTerm = json['policy_term'];
    mode = json['mode'];
    age = json['age'];
    ageMax = json['age_max'];
    maturityBenefit = json['maturity_benefit'];
    deathBenefit = json['death_benefit'];
    supplementaryInsuranceFacility = json['supplementary_insurance_facility'];
    investment = json['investment'];
    surrenderAndInvestmentFacility = json['surrender_and_investment_facility'];
    paidUpValue = json['paid_up_value'];
    incomeTaxRebateFacility = json['income_tax_rebate_facility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['description'] = description;
    data['sum_assured'] = sumAssured;
    data['policy_term'] = policyTerm;
    data['mode'] = mode;
    data['age'] = age;
    data['age_max'] = ageMax;
    data['maturity_benefit'] = maturityBenefit;
    data['death_benefit'] = deathBenefit;
    data['supplementary_insurance_facility'] = supplementaryInsuranceFacility;
    data['investment'] = investment;
    data['surrender_and_investment_facility'] = surrenderAndInvestmentFacility;
    data['paid_up_value'] = paidUpValue;
    data['income_tax_rebate_facility'] = incomeTaxRebateFacility;
    return data;
  }
}
