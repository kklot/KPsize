# KPsize

This is a base R code for fitting the model and extrapolate the sex initiation curve for UNAIDS key population estimates paper. While the data are freely available, it was not allow to redistribute. If needed, please contact k dot nguyen at imperial dot ac dot uk for information how to access and download.

- `data/nbmat.rds` neighbourhood structure of the countries in the model.
- `ne_10m_admin_0_countries_s01.gpkg` original map.
- `data/AFS_full.csv.bz2` is curated from three survey sources: DHS, NSFG and
  HBSC surveys.
- `code/smooth_KP_proportion.R`: this was used to extrapolate prevalence using Besag's model.
- `code/sexual_debut_survival_model`: this was used to estimate sexual debut rate.

There were 192 countries and regions included, but 80 were without the age at first sex data in this analyses. Those included:

```
                                AU                                 BT                                 BN 
                       "Australia"                           "Bhutan"                           "Brunei" 
                                CN                                 CK                                 KP 
                           "China"                     "Cook Islands"                      "North Korea" 
                                FJ                                 JP                                 KI 
                            "Fiji"                            "Japan"                         "Kiribati" 
                                LA                                 MY                                 MH 
                            "Laos"                         "Malaysia"                 "Marshall Islands" 
                                FM                                 MN                                 NZ 
"Micronesia (Federated States of)"                         "Mongolia"                      "New Zealand" 
                                PW                                 KR                                 WS 
                           "Palau"                      "South Korea"                            "Samoa" 
                                SG                                 SB                                 LK 
                       "Singapore"                  "Solomon Islands"                        "Sri Lanka" 
                                TO                                 TV                                 VU 
                           "Tonga"                           "Tuvalu"                          "Vanuatu" 
                                AG                                 BS                                 BB 
               "Antigua & Barbuda"                          "Bahamas"                         "Barbados" 
                                CU                                 DM                                 GD 
                            "Cuba"                         "Dominica"                          "Grenada" 
                                JM                                 KN                                 LC 
                         "Jamaica"                "St. Kitts & Nevis"                        "St. Lucia" 
                                VC                                 SR                                 BY 
        "St. Vincent & Grenadines"                         "Suriname"                          "Belarus" 
                                GE                                 TM                                 BW 
                         "Georgia"                     "Turkmenistan"                         "Botswana" 
                                ER                                 MU                                 SC 
                         "Eritrea"                        "Mauritius"                       "Seychelles" 
                                SS                                 AR                                 BZ 
                     "South Sudan"                        "Argentina"                           "Belize" 
                                BR                                 CL                                 CR 
                          "Brazil"                            "Chile"                       "Costa Rica" 
                                PA                                 UY                                 VE 
                          "Panama"                          "Uruguay"                        "Venezuela" 
                                DZ                                 BH                                 DJ 
                         "Algeria"                          "Bahrain"                         "Djibouti" 
                                IR                                 IQ                                 JO 
                            "Iran"                             "Iraq"                           "Jordan" 
                                KW                                 LB                                 LY 
                          "Kuwait"                          "Lebanon"                            "Libya" 
                                MA                                 OM                                 PS 
                         "Morocco"                             "Oman"          "Palestinian Territories" 
                                QA                                 SA                                 SO 
                           "Qatar"                     "Saudi Arabia"                          "Somalia" 
                                SD                                 SY                                 TN 
                           "Sudan"                            "Syria"                          "Tunisia" 
                                AE                                 YE                                 CV 
            "United Arab Emirates"                            "Yemen"                       "Cape Verde" 
                                GQ                                 GW                                 MR 
               "Equatorial Guinea"                    "Guinea-Bissau"                       "Mauritania" 
                                BA                                 CY                                 XK 
            "Bosnia & Herzegovina"                           "Cyprus"                                 NA 
                                ME                                 RS 
                      "Montenegro"                           "Serbia" 
```