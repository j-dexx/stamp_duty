# StampDuty

Calculates Stamp Duty Land Tax owed on a residential property purchase in England and Northern Ireland at the standard rates.

## Language

**Stamp Duty**:
Stamp Duty Land Tax (SDLT) owed on a purchase, rounded down to the whole pound.
_Avoid_: LBTT, LTT (Scottish and Welsh equivalents, out of scope)

**Purchase Price**:
The amount paid for the property, on which Stamp Duty is charged. Never negative.
_Avoid_: value, consideration

**Band**:
A slice of the Purchase Price between a lower and optional upper bound, taxed at a single percentage rate.
_Avoid_: bracket, tier

**Band Amount**:
The tax due on the part of a Purchase Price that falls within one Band.

## Relationships

- A **Purchase Price** falls into one or more **Bands**, starting from the lowest
- Each **Band** the price reaches produces one **Band Amount**
- **Stamp Duty** is the sum of the **Band Amounts**, rounded down to the pound

## Flagged ambiguities

- "Stamp duty" colloquially covers Scottish LBTT and Welsh LTT; here it means SDLT for England and Northern Ireland only.
- Surcharges (additional properties, non-residents) and reliefs (first-time buyers) are not modelled.
