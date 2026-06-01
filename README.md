#  Marketing Analytics

> End-to-end e-commerce analytics: SQL data engineering, Python sentiment analysis (VADER/NLTK), and Power BI dashboarding — applied to a fictional retail brand.

---

## Overview

This project simulates a real-world marketing analytics workflow for **NovaMart**, a fictional e-commerce retailer. The goal was to diagnose declining customer engagement and conversion rates using structured data analysis across four domains: customer demographics, product catalogue, customer journey behaviour, and campaign engagement.

The project covers the full analytics pipeline — from raw SQL data preparation through to a polished Power BI dashboard — and is documented as a portfolio case study.

---

## Business Problem

NovaMart's leadership identified four core challenges:

| Challenge | Description |
|---|---|
| Reduced Customer Engagement | Interactions with marketing content (clicks, likes, comments) declining across channels |
| Decreased Conversion Rates | Growing share of visitors leaving without purchasing |
| High Marketing Spend / Low ROI | Campaign budgets not producing expected revenue returns |
| Insufficient Customer Insight | Customer feedback not systematically analysed |

---

## Tech Stack

| Tool | Purpose |
|---|---|
| **SQL Server ** | Data extraction, cleansing, deduplication, and transformation |
| **Python 3.x** | Sentiment analysis via NLTK VADER; `pyodbc` for DB connectivity; `pandas` for data wrangling |
| **Power BI Desktop** | Interactive dashboard with KPI cards, funnel chart, and sentiment visuals |

---

## Project Structure

```
novamart-marketing-analytics/
│
├── sql/
│   ├── 01_products_price_tiers.sql          # Price tier classification (Low / Medium / High)
│   ├── 02_customers_geography.sql           # Customer enrichment with location data
│   ├── 03_customer_distribution.sql         # Country & city breakdown queries
│   ├── 04_reviews_text_cleaning.sql         # Review text cleansing (double-space removal)
│   ├── 05_engagement_normalisation.sql      # Content-type normalisation & field splitting
│   └── 06_journey_deduplication.sql         # CTE-based deduplication + NULL duration fill
│
├── python/
│   └── sentiment_analysis.py               # VADER scoring, categorisation & bucketing
│
├── powerbi/
│   └── NovaMart_Dashboard.pbix             # Power BI report file
│
├── report/
│   └── NovaMart_Marketing_Analytics_Report.docx
│
└── README.md
```

---

## Key Analyses

### 1. SQL Data Preparation

Five database tables were cleaned and transformed:

- **`dbo.products`** — Price tier classification using `CASE WHEN`
- **`dbo.customers` + `dbo.geography`** — LEFT JOIN for geographic enrichment
- **`dbo.customer_reviews`** — `REPLACE()` to remove double spaces before NLP
- **`dbo.engagement_data`** — `UPPER()` + `REPLACE()` for label normalisation; `CHARINDEX` to split combined views/clicks field; newsletter rows excluded
- **`dbo.customer_journey`** — `ROW_NUMBER()` CTE to deduplicate; `COALESCE` with daily average to handle NULL durations

### 2. Python Sentiment Analysis

Customer reviews were scored using **VADER** (Valence Aware Dictionary and sEntiment Reasoner) from NLTK — chosen for its strong performance on short, informal consumer text.

Each review received:
- A **compound score** (–1.0 to +1.0)
- A **sentiment category** (Positive / Mixed Positive / Neutral / Mixed Negative / Negative) based on score + star rating
- A **sentiment bucket** for distribution analysis

```python
from nltk.sentiment.vader import SentimentIntensityAnalyzer

sia = SentimentIntensityAnalyzer()

def get_sentiment_score(text):
    return sia.polarity_scores(text)['compound']

def categorize_sentiment(score, rating):
    if score > 0.05:
        if rating >= 4: return 'Positive'
        elif rating == 3: return 'Mixed Positive'
        else: return 'Mixed Negative'
    elif score < -0.05:
        if rating <= 2: return 'Negative'
        elif rating == 3: return 'Mixed Negative'
        else: return 'Mixed Positive'
    return {5:'Positive', 4:'Positive', 3:'Neutral', 2:'Negative', 1:'Negative'}.get(rating, 'Neutral')
```

### 3. Power BI Dashboard

The dashboard spans four pages:

| Page | Purpose |
|---|---|
| Executive Overview | KPI cards for CVR, ER, AOV, CFS with trend sparklines |
| Conversion Funnel | Stage-by-stage drop-off; filterable by product category and date |
| Engagement Analysis | Engagement rate by content type; campaign comparison |
| Sentiment Explorer | Sentiment distribution; word-cloud of review themes |

---

## Key Findings

- **Highest funnel drop-off** occurs at Cart → Checkout, indicating checkout friction (unexpected costs, complex forms)
- **Video content** consistently outperforms blog and social posts on clicks and likes
- **60%+ of reviews** are Positive or Mixed Positive; Negative reviews cluster around delivery delays and product-description mismatches
- **Customer concentration** is highest in three cities — a geo-targeting opportunity

---

## Recommendations

1. **Checkout** — Add a progress indicator, enable guest checkout, and show shipping costs upfront
2. **Content strategy** — Reallocate budget to short-form video; deprioritise low-engagement blog formats
3. **Product listings** — Improve description accuracy and set realistic delivery expectations at checkout
4. **Campaigns** — Design localised promotions for high-density markets

---

## Setup & Usage

### SQL

Run scripts in order from the `sql/` folder against a SQL Server instance with the `MarketingAnalytics` database.

### Python

```bash
pip install pandas pyodbc nltk
python -c "import nltk; nltk.download('vader_lexicon')"
python python/sentiment_analysis.py
```

Update the connection string in `sentiment_analysis.py` with your server details before running.

### Power BI

Open `powerbi/NovaMart_Dashboard.pbix` in Power BI Desktop and refresh the data source connection.

---

## Dataset

This project uses a fictional dataset created for portfolio purposes. All customer names, emails, and business data are synthetic. No real personal data is included.

---

## Skills Demonstrated

- SQL data engineering (CTEs, window functions, string manipulation, JOINs)
- NLP / text analytics with Python (NLTK VADER)
- Data cleaning and normalisation
- Business KPI definition and measurement
- Power BI dashboard design
- End-to-end analytics documentation

---

## License

This project is for portfolio and educational use only.
