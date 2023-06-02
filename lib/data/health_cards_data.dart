import 'package:desmokrizer/models/card_health.dart';

enum CardsCategory {
  pulse,
  oxygen,
  carbon,
  nicotine,
  tasteAndSmell,
  breathing,
  energy,
  badBreath,
  toothStaining,
  gumAndTeeth,
  circulation,
  gumTexture,
  immunity,
  heartDisease,
  lungCancer,
  heartAttack,
}

final Map<CardsCategory, CardHealth> cards = {
  CardsCategory.pulse: const CardHealth(
    cardName: "Pulse rate",
    shortDescription: "Your pulse rate should have returned to normal",
    lonbgDescription:
        "Quitting smoking improves pulse rate by allowing the heart to work more efficiently. When individuals stop smoking, their blood vessels relax, enabling better blood flow. As a result, the heart doesn't have to pump as hard, leading to a healthier and more stable pulse rate. Quitting smoking is crucial for overall cardiovascular health.",
    image: "assets/images/pulse.png",
    durationToRecover: Duration(minutes: 20),
  ),
  CardsCategory.oxygen: const CardHealth(
    cardName: "Oxygen levels",
    shortDescription: "Your oxygen levels should have returned to normal",
    lonbgDescription:
        "Quitting smoking boosts oxygen levels by allowing the lungs to heal and function better. With improved lung capacity, the body receives an increased supply of oxygen, benefiting overall health. Quitting smoking is vital for restoring optimal oxygen levels.",
    image: "assets/images/oxygen.png",
    durationToRecover: Duration(hours: 8),
  ),
  CardsCategory.carbon: const CardHealth(
    cardName: "Carbon monoxide",
    shortDescription:
        "Your carbon monoxide from smoking will have been eliminated from your body",
    lonbgDescription:
        "When individuals quit smoking, their carbon monoxide levels significantly decrease. Smoking introduces carbon monoxide into the bloodstream, reducing the capacity of red blood cells to carry oxygen. However, quitting smoking allows the body to clear out carbon monoxide, improving oxygen transportation and overall health.",
    image: "assets/images/carbon.png",
    durationToRecover: Duration(hours: 24),
  ),
  CardsCategory.nicotine: const CardHealth(
    cardName: "Nicotine",
    shortDescription: "All nicotine should now have been expelled",
    lonbgDescription:
        "After quitting smoking, the body begins to eliminate nicotine. Through metabolic processes, nicotine is broken down and expelled from the body. As time passes, nicotine levels gradually decrease, leading to reduced cravings and withdrawal symptoms. Quitting smoking allows the body to rid itself of nicotine and promotes a healthier, nicotine-free lifestyle.",
    image: "assets/images/nicotine.png",
    durationToRecover: Duration(days: 2),
  ),
  CardsCategory.tasteAndSmell: const CardHealth(
    cardName: "Taste and smell",
    shortDescription:
        "Your ability to taste and smell should be greatly improved",
    lonbgDescription:
        "Quitting smoking enhances the sense of taste and smell. Smoking can dull these senses over time, but when individuals quit, the taste buds and olfactory receptors start to recover. This leads to a heightened ability to savor flavors and enjoy the aromas of food, ultimately enriching the overall sensory experience.",
    image: "assets/images/nose.png",
    durationToRecover: Duration(days: 2, hours: 12),
  ),
  CardsCategory.breathing: const CardHealth(
    cardName: "Breathing",
    shortDescription:
        "Your bronchial tubes have begun to relax and your breathing should be easier",
    lonbgDescription:
        "Quitting smoking greatly improves breathing. Smoking damages the lungs and reduces their capacity, making it harder to breathe. However, when individuals quit smoking, their lung function gradually improves, allowing for easier and more efficient breathing. Quitting smoking is essential for restoring and maintaining optimal respiratory health.",
    image: "assets/images/breathing.png",
    durationToRecover: Duration(days: 3),
  ),
  CardsCategory.energy: const CardHealth(
    cardName: "Energy levels",
    shortDescription: "Your energy levels should have returned to normal",
    lonbgDescription:
        "After quitting smoking, energy levels experience a noticeable improvement. Smoking can cause fatigue and decrease overall stamina. However, when individuals quit smoking, their circulation improves, oxygen levels increase, and the body's energy production becomes more efficient. This results in higher energy levels and a greater sense of vitality.",
    image: "assets/images/energy.png",
    durationToRecover: Duration(days: 4),
  ),
  CardsCategory.badBreath: const CardHealth(
    cardName: "Bad breath",
    shortDescription: "Any Smoking-realted bad breath should now have gone",
    lonbgDescription:
        "Quitting smoking leads to a significant improvement in bad breath. Smoking can cause persistent bad breath due to the tobacco's strong odor and its impact on oral health. However, when individuals quit smoking, their breath gradually becomes fresher as the odor-causing chemicals dissipate and oral hygiene improves.",
    image: "assets/images/bad-breath.png",
    durationToRecover: Duration(days: 7),
  ),
  CardsCategory.toothStaining: const CardHealth(
    cardName: "Tooth staining",
    shortDescription:
        "Your tooth staining and calculus build-up from smoking should be reduced",
    lonbgDescription:
        "Quitting smoking results in a reduction in tooth staining. Smoking tobacco can lead to yellowing and discoloration of the teeth over time. However, when individuals quit smoking, the staining process slows down and the natural color of the teeth becomes more evident. ",
    image: "assets/images/tooth-staining.png",
    durationToRecover: Duration(days: 14),
  ),
  CardsCategory.gumAndTeeth: const CardHealth(
    cardName: "Gums and teeth",
    shortDescription:
        "The blood circulation in your gums and teeth should be similar to that of a non-smoker",
    lonbgDescription:
        "Quitting smoking has a positive impact on gum and teeth health. Smoking increases the risk of gum disease and tooth loss due to reduced blood flow and compromised immune function. However, when individuals quit smoking, blood flow improves, reducing inflammation and promoting healthier gums and stronger teeth",
    image: "assets/images/gum-and-teeth.png",
    durationToRecover: Duration(days: 14),
  ),
  CardsCategory.circulation: const CardHealth(
    cardName: "Circulation",
    shortDescription: "Your circulation should be greatly improved",
    lonbgDescription:
        "Quitting smoking significantly improves circulation. Smoking damages blood vessels and reduces their ability to deliver oxygen and nutrients throughout the body. However, when individuals quit smoking, blood vessels gradually heal and become more efficient, leading to improved circulation",
    image: "assets/images/circulation.png",
    durationToRecover: Duration(days: 70, hours: 12),
  ),
  CardsCategory.gumTexture: const CardHealth(
    cardName: "Gum texture",
    shortDescription:
        "The texture and color of your gums should be back to normal",
    lonbgDescription:
        "Quitting smoking leads to improved gum texture. Smoking can cause gum tissue to become inflamed and lose its healthy appearance. However, when individuals quit smoking, the gums gradually heal, becoming firmer and less prone to inflammation.",
    image: "assets/images/gum-texture.png",
    durationToRecover: Duration(days: 88, hours: 24),
  ),
  CardsCategory.immunity: const CardHealth(
    cardName: "Immunity",
    shortDescription: "Your immunity and lung function should be improved",
    lonbgDescription:
        "Quitting smoking results in improved immunity and lung function. Smoking weakens the immune system, making individuals more susceptible to infections and respiratory illnesses. However, when individuals quit smoking, their immune system strengthens, reducing the risk of illness. Additionally, lung function improves as the lungs heal and regain their capacity to efficiently process oxygen.",
    image: "assets/images/immunity.png",
    durationToRecover: Duration(days: 138),
  ),
  CardsCategory.heartDisease: const CardHealth(
    cardName: "heart disease",
    shortDescription:
        "Your risk of heart disease has fallen to about half of that of a smoker",
    lonbgDescription:
        "Quitting smoking reduces the risk of heart disease. Smoking is a leading cause of heart disease due to its detrimental effects on blood vessels, increased blood pressure, and promotion of blood clots. When individuals quit smoking, their cardiovascular health improves, reducing the likelihood of developing heart disease.",
    image: "assets/images/heart-disease.png",
    durationToRecover: Duration(days: 360, hours: 6),
  ),
  CardsCategory.lungCancer: const CardHealth(
    cardName: "lung cancer",
    shortDescription:
        "Your risk of lung cancer has fallen to about half of that of smoker",
    lonbgDescription:
        "Quitting smoking significantly reduces the risk of lung cancer. Smoking is a major cause of lung cancer, and by quitting, individuals decrease their exposure to harmful chemicals and toxins present in tobacco smoke. Over time, the lung tissue can begin to repair itself, lowering the likelihood of developing lung cancer.",
    image: "assets/images/lung-cancer.png",
    durationToRecover: Duration(days: 3643),
  ),
  CardsCategory.heartAttack: const CardHealth(
    cardName: "heart attack",
    shortDescription:
        "Your risk of heart attack has fallen to about half of that of a smoker",
    lonbgDescription:
        "Quitting smoking decreases heart attack risk by improving cardiovascular health, healing damaged blood vessels, and reducing blood clot formation.",
    image: "assets/images/heart-attack.png",
    durationToRecover: Duration(days: 5470, hours: 18),
  ),
};
