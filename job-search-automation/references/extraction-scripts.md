# Extraction Scripts Reference — Job Search Automation

## LinkedIn Job Cards (via `evaluate`)

```javascript
// Run after snapshot shows job cards with [data-job-id]
// Returns array of {title, company, location, link, salary}
var jobs = document.querySelectorAll("[data-job-id]");
var results = [];
for (var i = 0; i < Math.min(10, jobs.length); i++) {
  var el = jobs[i];
  var title = (el.querySelector("[data-job-title]") || el.querySelector("h3") || el.querySelector("a"))?.textContent?.trim() || "";
  var company = (el.querySelector("[data-company-name]") || el.querySelector(".job-card-container__company-name"))?.textContent?.trim() || "";
  var location = (el.querySelector("[data-job-location]") || el.querySelector(".job-card-container__location"))?.textContent?.trim() || "";
  var link = (el.querySelector("a[href*='/jobs/view/']") || el.querySelector("a"))?.href || "";
  var salary = el.querySelector("[data-salary]")?.textContent?.trim() || "";
  results.push({title, company, location, link, salary});
}
results;
```

## LinkedIn Job Detail Page (after clicking into a job)

```javascript
// Run on job detail page (after clicking a job card)
// Returns full job description, requirements, benefits
var description = document.querySelector(".jobs-description__content")?.textContent?.trim() || "";
var criteria = Array.from(document.querySelectorAll(".jobs-description__job-criteria-item")).map(el => el.textContent?.trim() || "").join("; ");
var benefits = document.querySelector(".jobs-unified-top-card__benefits")?.textContent?.trim() || "";
var company = document.querySelector(".jobs-unified-top-card__company-name")?.textContent?.trim() || "";
var location = document.querySelector(".jobs-unified-top-card__bullet")?.textContent?.trim() || "";
{description, criteria, benefits, company, location};
```

## Indeed Job Cards (via snapshot `@e` refs)

```javascript
// Use snapshot to find job card @e refs, then click each
// Or use evaluate on search results page:
var cards = document.querySelectorAll(".job_seen_beacon, [data-jk], .resultContent");
var results = [];
for (var i = 0; i < Math.min(10, cards.length); i++) {
  var el = cards[i];
  var title = el.querySelector("h2 a, h2 span")?.textContent?.trim() || "";
  var company = el.querySelector("[data-testid='company-name'], .companyName")?.textContent?.trim() || "";
  var location = el.querySelector("[data-testid='job-location'], .companyLocation")?.textContent?.trim() || "";
  var salary = el.querySelector(".salary-snippet, [data-testid='salary']")?.textContent?.trim() || "";
  var link = el.querySelector("h2 a")?.href || "";
  results.push({title, company, location, salary, link});
}
results;
```

## Dice Job Cards (via evaluate)

```javascript
// After accepting cookie consent
var cards = document.querySelectorAll(".card, .search-result-card, [data-cy='job-card']");
var results = [];
for (var i = 0; i < Math.min(15, cards.length); i++) {
  var el = cards[i];
  var title = el.querySelector("h2 a, .card-title a")?.textContent?.trim() || "";
  var company = el.querySelector(".card-company, [data-cy='company-name']")?.textContent?.trim() || "";
  var location = el.querySelector(".card-location, [data-cy='location']")?.textContent?.trim() || "";
  var salary = el.querySelector(".card-salary, [data-cy='salary']")?.textContent?.trim() || "";
  var link = el.querySelector("h2 a, .card-title a")?.href || "";
  var type = el.querySelector(".card-type, [data-cy='job-type']")?.textContent?.trim() || "";
  results.push({title, company, location, salary, link, type});
}
results;
```

## Glassdoor Job Cards (via evaluate on .co.in domain)

```javascript
// Use .co.in domain to avoid geo-redirect
var cards = document.querySelectorAll(".jobCard, [data-test='job-card'], .react-job-listing");
var results = [];
for (var i = 0; i < Math.min(10, cards.length); i++) {
  var el = cards[i];
  var title = el.querySelector(".jobTitle, [data-test='job-title']")?.textContent?.trim() || "";
  var company = el.querySelector(".employerName, [data-test='employer-name']")?.textContent?.trim() || "";
  var location = el.querySelector(".location, [data-test='location']")?.textContent?.trim() || "";
  var salary = el.querySelector(".salaryEstimate, [data-test='salary']")?.textContent?.trim() || "";
  var link = el.querySelector("a[href*='/job/']")?.href || "";
  results.push({title, company, location, salary, link});
}
results;
```

## Naukri Job Cards (via evaluate)

```javascript
// Naukri search results page
var cards = document.querySelectorAll(".srp-jobtuple-wrapper, .jobTuple, [data-job-id]");
var results = [];
for (var i = 0; i < Math.min(10, cards.length); i++) {
  var el = cards[i];
  var title = el.querySelector(".title, .job-title a")?.textContent?.trim() || "";
  var company = el.querySelector(".comp-name, .companyName")?.textContent?.trim() || "";
  var location = el.querySelector(".locWdth, .location")?.textContent?.trim() || "";
  var salary = el.querySelector(".salary, .sal")?.textContent?.trim() || "";
  var link = el.querySelector(".title a, .job-title a")?.href || "";
  var experience = el.querySelector(".expwdth, .experience")?.textContent?.trim() || "";
  var skills = Array.from(el.querySelectorAll(".tags-gt a, .skillTags a")).map(a => a.textContent?.trim()).join(", ") || "";
  results.push({title, company, location, salary, link, experience, skills});
}
results;
```

## Salary Parsing Helpers

```javascript
// Parse various salary formats to annual USD
function parseSalary(text) {
  if (!text) return {min: null, max: null, period: null, currency: "USD"};
  text = text.replace(/[,$]/g, "");
  
  // $200K - $300K/yr
  var m = text.match(/\$?(\d+(?:\.\d+)?)\s*[Kk]?\s*[-–]\s*\$?(\d+(?:\.\d+)?)\s*[Kk]?\s*\/?\s*(yr|year|annual)/i);
  if (m) return {min: parseFloat(m[1])*1000, max: parseFloat(m[2])*1000, period: "year", currency: "USD"};
  
  // $100 - $150/hr
  m = text.match(/\$?(\d+(?:\.\d+)?)\s*[-–]\s*\$?(\d+(?:\.\d+)?)\s*\/?\s*(hr|hour)/i);
  if (m) return {min: parseFloat(m[1])*2080, max: parseFloat(m[2])*2080, period: "hour", currency: "USD"};
  
  // ₹20,000 - ₹30,000/month
  m = text.match(/₹?(\d+(?:,\d+)*)\s*[-–]\s*₹?(\d+(?:,\d+)*)\s*\/?\s*(month|mo)/i);
  if (m) return {min: parseFloat(m[1].replace(/,/g,""))*12, max: parseFloat(m[2].replace(/,/g,""))*12, period: "month", currency: "INR"};
  
  // Single value: $200K
  m = text.match(/\$?(\d+(?:\.\d+)?)\s*[Kk]\s*\/?\s*(yr|year|annual)/i);
  if (m) return {min: parseFloat(m[1])*1000, max: parseFloat(m[1])*1000, period: "year", currency: "USD"};
  
  return {min: null, max: null, period: null, currency: "USD", raw: text};
}
```

## Kimi WebBridge Command Patterns

```bash
# Navigate to search URL in new tab (grouped by session)
curl -s -X POST http://127.0.0.1:10086/command \
  -H 'Content-Type: application/json' \
  -d '{"action":"navigate","args":{"url":"<SEARCH_URL>","newTab":true,"group_title":"<GROUP_LABEL>"},"session":"<SESSION_NAME>"}'

# Wait for page load
sleep 3

# Get full accessibility tree
curl -s -X POST http://127.0.0.1:10086/command \
  -H 'Content-Type: application/json' \
  -d '{"action":"snapshot","args":{"full":true},"session":"<SESSION_NAME>"}'

# Run extraction script on current tab
curl -s -X POST http://127.0.0.1:10086/command \
  -H 'Content-Type: application/json' \
  -d '{"action":"evaluate","args":{"code":"<JS_SCRIPT>","returnByValue":true},"session":"<SESSION_NAME>"}'

# Click element by @e ref
curl -s -X POST http://127.0.0.1:10086/command \
  -H 'Content-Type: application/json' \
  -d '{"action":"click","args":{"selector":"@e<REF_ID>"},"session":"<SESSION_NAME>"}'

# Close all tabs in session
curl -s -X POST http://127.0.0.1:10086/command \
  -H 'Content-Type: application/json' \
  -d '{"action":"close_session","args":{},"session":"<SESSION_NAME>"}'
```

## Tab Group Search Workflow (N Tabs)

```bash
session="job-search-<TOPIC>"
group_title="Job Search - <TOPIC>"

# Define search URLs with user-provided keywords
SEARCH_URLS=(
  "https://in.indeed.com/jobs?q=<KEYWORDS1>&location=Remote"
  "https://in.indeed.com/jobs?q=<KEYWORDS2>&location=Remote"
  "https://www.linkedin.com/jobs/search/?keywords=<KEYWORDS3>&location=India&f_WT=2"
  "https://www.naukri.com/<ROLE>-jobs-in-india?k=<KEYWORDS4>&experience=0-3&location=remote"
  # Add more as needed
)

for url in "${SEARCH_URLS[@]}"; do
  curl -s -X POST http://127.0.0.1:10086/command \
    -H 'Content-Type: application/json' \
    -d "{\"action\":\"navigate\",\"args\":{\"url\":\"$url\",\"newTab\":true,\"group_title\":\"$group_title\"},\"session\":\"$session\"}"
done

# Extract from each tab
for i in {0..9}; do
  curl -s -X POST http://127.0.0.1:10086/command \
    -H 'Content-Type: application/json' \
    -d "{\"action\":\"find_tab\",\"args\":{\"url\":\"${SEARCH_URLS[i]}\"},\"session\":\"$session\"}"
  curl -s -X POST http://127.0.0.1:10086/command \
    -H 'Content-Type: application/json' \
    -d "{\"action\":\"snapshot\",\"args\":{\"full\":true},\"session\":\"$session\"}"
  # Then run platform-specific evaluate script
done

# Cleanup
curl -s -X POST http://127.0.0.1:10086/command \
  -H 'Content-Type: application/json' \
  -d "{\"action\":\"close_session\",\"args\":{},\"session\":\"$session\"}"
```