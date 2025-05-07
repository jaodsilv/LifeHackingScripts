# `fast_learning` Command Documentation
SCOPE: project

## Purpose
The `fast_learning` command writes a customized short document reading document tailored to my needs and knowledge level.

## Basic Syntax
```
fast_learning <topic> [start_level:<value>] [constraints:<value>] [length:<value>]
```

## Parameters

| Parameter | Description | Required | Example Values | Default Value |
|-----------|-------------|----------|----------------|---------------|
| `topic` | Topic to Learn | Yes* | `Django`, `behavioral_interviews`, `JavaScript` | `None` |
| `topics` | Topics to Learn | Yes* | [`Django`, `behavioral_interviews`, `JavaScript`] | `None` |
| `start_level` | Initial level of knowledge about the topic | No | `beginner`, `advanced`, `proficient` | `beginner` |
| `constraints` | Other constraints consideration for when writing the document | No | `I am proficient in Go already` | `None` |
| `length` | Length of the document in expected time to read | No | `10min`, `1h` | `10min` |

* Either `topic` or `topics` must be present, in case both are present, $topics + [$topic] will be used.
* if more than one topic is provided, the command will generate a separate document for each topic.

## Examples

```bash
# Basic usage with just a topic
fast_learning Django

# Specify a different starting knowledge level
fast_learning behavioral_interviews start_level:advanced

# Add constraints about existing knowledge
fast_learning JavaScript constraints:"I am proficient in Go already"

# Request a longer document
fast_learning system_design length:1h

# Combine multiple parameters
fast_learning machine_learning start_level:beginner length:30min constraints:"I have a strong math background"
```

## Behavior

When executed, the command will:

1. Analyze the provided topic and parameters to determine the appropriate scope and depth
2. Generate a structured document with the following sections:
   - Title (including expected reading time)
   - Brief overview of the topic
   - Core concepts and key points
   - Practical examples or use cases
   - Common pitfalls or challenges
   - Prompts for deeper learning at the end of each section. These should no be computed in the reading time.

3. Format the output as a markdown document with:
   - Clear section headers
   - Code blocks where relevant
   - Bullet points for key concepts
   - Links to additional resources
   - Interactive prompts for deeper exploration

4. The document will be:
   - Tailored to the specified `start_level`
   - Respect any provided `constraints`
   - Optimized for the requested `length`
   - Focused on practical, actionable knowledge

5. The output will be displayed in an artifact.

## Usage Notes

- The command is designed to be interactive, allowing for follow-up questions
- The generated document can serve as a starting point for deeper learning
- The prompts at the end of each section can be used to explore specific aspects in more detail
- The document structure may vary slightly depending on the topic and parameters provided
