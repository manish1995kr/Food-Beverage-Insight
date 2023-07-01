Provide Insights to the Marketing Team in Food & Beverage Industry
1. Demographic Insights (examples)
   a. Who prefers energy drink more? (male/female/non-binary?)
   b. Which age group prefers energy drinks more?
   c. Which type of marketing reaches the most Youth (15-30)?

a. select Gender, count(Gender) as total from dim_repondents group by Gender order by total desc;
   
b. select Age, count(*) as total from dim_repondents group by Age order by total desc;

c. SELECT Age, Marketing_channels, COUNT(*) as marketing_type
   FROM dim_repondents
   INNER JOIN fact_survey_responses ON dim_repondents.Respondent_ID = fact_survey_responses.Respondent_ID
   GROUP BY Age
   ORDER BY marketing_type DESC;

2. Consumer Preferences:
a. What are the preferred ingredients of energy drinks among respondents?
b. What packaging preferences do respondents have for energy drinks?

a. select Ingredients_expected, count(Respondent_ID) as Total_Respondent from fact_survey_responses group by Ingredients_expected
    order by Total_Respondent desc;

b. select Packaging_preference, count(Respondent_ID) as Total_Respondent from fact_survey_responses group by packaging_preference
order by Total_Respondent desc;

3. Competition Analysis:
a. Who are the current market leaders?
b. What are the primary reasons consumers prefer those brands over ours?

a. select Current_brands, count(Current_brands) as Market_leader from fact_survey_responses group by Current_brands
order by Market_leader desc;

b. select Current_brands, Reasons_for_choosing_brands, count(Reasons_for_choosing_brands) as no_of_responese,
round(100*count(Reasons_for_choosing_brands)/ sum(count(Reasons_for_choosing_brands)) over (),2) 
as "no_of_responses_%" from fact_survey_responses group by Current_brands, Reasons_for_choosing_brands having Current_brands != "Others"
order by Current_brands, "no_of_responses_%" desc;
      
4. Marketing Channels and Brand Awareness:
a. Which marketing channel can be used to reach more customers?
b. How effective are different marketing strategies and channels in reaching our customers?

a. select Marketing_channels, count(Respondent_ID) as most_like_channel from fact_survey_responses
  group by Marketing_channels order by most_like_channel desc;
  
  (Question 4 a and b are the almost same thats why give a single code which solve the both the question)

5. Brand Penetration:
a. What do people think about our brand? (overall rating)
b. Which cities do we need to focus more on?

a. select Current_brands, Brand_perception , count(Brand_perception) As feedback_count , 
round(100*count(Brand_perception)/ sum(count(Brand_perception)) over (),2) as "feedback_count_%" from fact_survey_responses
where current_brands = "Codex" group by Brand_perception order by feedback_count desc;

b. select city_.City, count(repon.Respondent_ID) as Total_Respondent from dim_cities as city_ join dim_repondents as repon on 
city_.City_ID = repon.City_ID join fact_survey_responses as fact on repon.Respondent_ID = fact.Respondent_ID
where fact.Current_brands = "CodeX" group by city_.City order by Total_Respondent desc;

6. Purchase Behavior:
a. Where do respondents prefer to purchase energy drinks?
b. What are the typical consumption situations for energy drinks among respondents?
c. What factors influence respondents purchase decisions, such as price range and limited edition packaging?

a. select Purchase_location, count(Respondent_ID) as Respondent_prefer,
round(100*count(Respondent_ID)/ Sum(count(Respondent_ID)) over(),2) as "Respondent_%" from fact_survey_responses
 group by Purchase_location order by Respondent_prefer desc;

b. select Typical_consumption_situations, count(Respondent_ID) as Respondent_prefer, 
round(100*count(Respondent_ID)/ Sum(count(Respondent_ID)) over(),2) as "Respondent_%"
from fact_survey_responses group by Typical_consumption_situations order by Respondent_prefer desc;

c. # Purchase behaviour w.r.t price range:
select Price_range, count(Respondent_ID) as customer_count from fact_survey_responses group by Price_range
order by customer_count desc;
   
   # Purchase behaviour w.r.t limited edition packaging:
select Limited_edition_packaging, count(Respondent_ID) as customer_count from fact_survey_responses group by Limited_edition_packaging
order by customer_count desc;

   # Purchase behaviour w.r.t general perceptions:
select General_perception, count(Respondent_ID) as customer_count from fact_survey_responses group by General_perception
order by customer_count desc;

   # Purchase behaviour w.r.t health concerns:
select Health_concerns, count(Respondent_ID) as customer_count from fact_survey_responses group by Health_concerns
order by customer_count desc;

7. Product Development
a. Which area of business should we focus more on our product development? (Branding/taste/availability)

a. select Reasons_for_choosing_brands, count(Reasons_for_choosing_brands) as Focus_on from fact_survey_responses
where Current_brands = "CodeX" group by Reasons_for_choosing_brands order by Focus_on desc;