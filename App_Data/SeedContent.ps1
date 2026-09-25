$mdf = (Resolve-Path "App_Data\aspnet-Codelecta_2.0-20260812124505.mdf").Path
$connStr = "Server=(localdb)\MSSQLLocalDB;AttachDbFilename='$mdf';Integrated Security=True;"
$conn = New-Object System.Data.SqlClient.SqlConnection($connStr)

try {
    $conn.Open()
    Write-Host "Connected to LocalDB database."

    # 1. Fetch user IDs
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "SELECT Id, UserName FROM AspNetUsers"
    $reader = $cmd.ExecuteReader()
    $users = @{}
    while ($reader.Read()) {
        $users[$reader["UserName"].ToString().ToLower()] = $reader["Id"].ToString()
    }
    $reader.Close()

    $userId = $users["user@gmail.com"]
    $testId = $users["test@gmail.com"]
    $user1Id = $users["user1@gmail.com"]
    $beginnerId = $users["beginner@gmail.com"]

    # 2. Insert 8 Quizzes with 5 Questions each
    $quizzes = @(
        @{
            CourseId = 1
            Title = "Python Fundamentals Mastery Assessment"
            Description = "Validate your understanding of variables, control flow, functions, and list data structures in Python."
            PassingScore = 70
            Questions = @(
                @{
                    Order = 1
                    Text = "Which of the following data types is immutable in Python?"
                    A = "List"; B = "Dictionary"; C = "Tuple"; D = "Set"
                    Correct = "C"
                    Explanation = "Tuples in Python cannot be modified after creation, making them immutable."
                },
                @{
                    Order = 2
                    Text = "What will the expression len(range(1, 10, 2)) return?"
                    A = "4"; B = "5"; C = "9"; D = "10"
                    Correct = "B"
                    Explanation = "range(1, 10, 2) produces the numbers 1, 3, 5, 7, 9 which has 5 items."
                },
                @{
                    Order = 3
                    Text = "How do you define a function in Python?"
                    A = "function myFunc():"; B = "def myFunc():"; C = "create myFunc():"; D = "func myFunc():"
                    Correct = "B"
                    Explanation = "The 'def' keyword is used to declare functions in Python."
                },
                @{
                    Order = 4
                    Text = "What is the correct syntax to output 'Hello World' in Python 3?"
                    A = "echo 'Hello World'"; B = "print('Hello World')"; C = "Console.WriteLine('Hello World')"; D = "System.out.println('Hello World')"
                    Correct = "B"
                    Explanation = "print() is the built-in function for output in Python 3."
                },
                @{
                    Order = 5
                    Text = "Which method can be used to remove any whitespace from both the beginning and end of a string?"
                    A = "strip()"; B = "trim()"; C = "clean()"; D = "slice()"
                    Correct = "A"
                    Explanation = "The strip() method removes leading and trailing whitespaces in Python."
                }
            )
        },
        @{
            CourseId = 2
            Title = "HTML5 & CSS3 Responsive Layouts Assessment"
            Description = "Demonstrate core competence in modern semantic HTML5 markup, CSS box model, and flexbox grids."
            PassingScore = 70
            Questions = @(
                @{
                    Order = 1
                    Text = "Which HTML5 semantic element is most appropriate for a standalone blog post or article?"
                    A = "<div>"; B = "<article>"; C = "<section>"; D = "<aside>"
                    Correct = "B"
                    Explanation = "The <article> element specifies independent, self-contained content."
                },
                @{
                    Order = 2
                    Text = "In the CSS box model, which layer comes immediately outside the content area?"
                    A = "Margin"; B = "Border"; C = "Padding"; D = "Outline"
                    Correct = "C"
                    Explanation = "The CSS box model layers from inside out are: Content -> Padding -> Border -> Margin."
                },
                @{
                    Order = 3
                    Text = "Which CSS flexbox property aligns flex items along the main axis?"
                    A = "align-items"; B = "justify-content"; C = "align-content"; D = "flex-direction"
                    Correct = "B"
                    Explanation = "justify-content defines the alignment along the main axis."
                },
                @{
                    Order = 4
                    Text = "What is the primary purpose of the viewport meta tag in responsive web design?"
                    A = "To enable search engine indexing"; B = "To control the page dimensions and scaling on mobile devices"; C = "To import external fonts"; D = "To cache CSS stylesheets"
                    Correct = "B"
                    Explanation = "The viewport meta tag tells mobile browsers how to set the screen width and initial zoom scale."
                },
                @{
                    Order = 5
                    Text = "Which CSS unit is relative to the font-size of the root <html> element?"
                    A = "em"; B = "px"; C = "rem"; D = "vh"
                    Correct = "C"
                    Explanation = "rem stands for 'root em' and is proportional to the root element's font size."
                }
            )
        },
        @{
            CourseId = 3
            Title = "Modern JavaScript Essentials Assessment"
            Description = "Test your skills with ES6+ syntax, asynchronous promises, scope, and DOM interactions."
            PassingScore = 70
            Questions = @(
                @{
                    Order = 1
                    Text = "What is the key difference between 'let' and 'var' in modern JavaScript?"
                    A = "let is block-scoped while var is function-scoped"; B = "var cannot be reassigned"; C = "let is globally hoisted"; D = "There is no difference"
                    Correct = "A"
                    Explanation = "let declares block-scoped variables, preventing unintended leakage outside blocks."
                },
                @{
                    Order = 2
                    Text = "What does the promise state 'fulfilled' indicate?"
                    A = "The operation is currently running"; B = "The operation completed successfully"; C = "The operation failed with an error"; D = "The promise was cancelled"
                    Correct = "B"
                    Explanation = "A fulfilled promise means the async operation has completed successfully with a resolved value."
                },
                @{
                    Order = 3
                    Text = "Which array method creates a new array with all elements that pass a provided test function?"
                    A = "map()"; B = "filter()"; C = "reduce()"; D = "forEach()"
                    Correct = "B"
                    Explanation = "filter() returns a new array with items that evaluate to true."
                },
                @{
                    Order = 4
                    Text = "What is the return value of typeof null in JavaScript?"
                    A = "'null'"; B = "'undefined'"; C = "'object'"; D = "'number'"
                    Correct = "C"
                    Explanation = "Due to a historic implementation detail in JavaScript, typeof null returns 'object'."
                },
                @{
                    Order = 5
                    Text = "Which syntax represents an ES6 arrow function?"
                    A = "function = () => {}"; B = "() => {}"; C = "function() => {}"; D = "def () -> {}"
                    Correct = "B"
                    Explanation = "() => {} is the standard concise arrow function syntax in ES6."
                }
            )
        },
        @{
            CourseId = 4
            Title = "C# & .NET Architecture Assessment"
            Description = "Validate OOP patterns, LINQ queries, generic collections, and memory management in C#."
            PassingScore = 70
            Questions = @(
                @{
                    Order = 1
                    Text = "In C#, what is the base class from which all types directly or indirectly derive?"
                    A = "System.Type"; B = "System.ValueType"; C = "System.Object"; D = "System.Class"
                    Correct = "C"
                    Explanation = "System.Object (or the 'object' alias) is the ultimate root base class in .NET."
                },
                @{
                    Order = 2
                    Text = "Which LINQ method is used to filter elements in a sequence based on a predicate?"
                    A = "Select"; B = "Where"; C = "GroupBy"; D = "OrderBy"
                    Correct = "B"
                    Explanation = "Where filters an IEnumerable based on a boolean condition."
                },
                @{
                    Order = 3
                    Text = "What keyword is used to ensure that unmanaged resources are deterministically released via IDisposable?"
                    A = "using"; B = "try"; C = "finally"; D = "lock"
                    Correct = "A"
                    Explanation = "The 'using' statement guarantees Dispose() is called on the disposable object."
                },
                @{
                    Order = 4
                    Text = "What is the primary difference between a struct and a class in C#?"
                    A = "Structs are reference types; classes are value types"; B = "Structs are value types; classes are reference types"; C = "Structs support multiple inheritance"; D = "Classes cannot implement interfaces"
                    Correct = "B"
                    Explanation = "Structs are value types allocated on the stack/inline, whereas classes are reference types."
                },
                @{
                    Order = 5
                    Text = "Which access modifier restricts access to members only within the current assembly or derived classes in the same assembly?"
                    A = "protected"; B = "internal"; C = "private protected"; D = "protected internal"
                    Correct = "C"
                    Explanation = "private protected allows access within the containing class and derived classes in the same assembly."
                }
            )
        },
        @{
            CourseId = 5
            Title = "React - Component Architecture & Hooks Assessment"
            Description = "Evaluate your knowledge of React hooks, component lifecycles, and state management."
            PassingScore = 70
            Questions = @(
                @{
                    Order = 1
                    Text = "Which React hook is used to manage mutable local state in functional components?"
                    A = "useEffect"; B = "useState"; C = "useContext"; D = "useMemo"
                    Correct = "B"
                    Explanation = "useState returns a stateful value and a function to update it."
                },
                @{
                    Order = 2
                    Text = "When does a useEffect with an empty dependency array '[]' run?"
                    A = "On every component re-render"; B = "Only once after initial mount"; C = "Never"; D = "Whenever any prop changes"
                    Correct = "B"
                    Explanation = "An empty dependency array causes the effect to run only once after the component mounts."
                },
                @{
                    Order = 3
                    Text = "Why should list items in React always have a unique 'key' prop?"
                    A = "For CSS styling purposes"; B = "To enable React's reconciliation algorithm to track added, changed, or removed items"; C = "To sort the list automatically"; D = "Keys are required by HTML standards"
                    Correct = "B"
                    Explanation = "Unique keys allow React to identify which items have changed, been added, or been removed efficiently."
                },
                @{
                    Order = 4
                    Text = "How are props passed from a parent component to a child in JSX?"
                    A = "Via HTML data attributes"; B = "As attributes in the JSX tag like <Child name='Alex' />"; C = "Via global window variables"; D = "Using setState"
                    Correct = "B"
                    Explanation = "Props are passed as custom attributes directly to JSX component tags."
                },
                @{
                    Order = 5
                    Text = "What is the Virtual DOM in React?"
                    A = "A direct clone of the browser's native DOM"; B = "A lightweight in-memory representation of the real DOM used for reconciliation"; C = "A browser extension"; D = "A third-party database"
                    Correct = "B"
                    Explanation = "React's Virtual DOM is an in-memory tree that is diffed against the previous tree to minimize real DOM mutations."
                }
            )
        },
        @{
            CourseId = 6
            Title = "Java Object-Oriented Principles Assessment"
            Description = "Test your grasp of core Java OOP concepts: inheritance, polymorphism, encapsulation, and interfaces."
            PassingScore = 70
            Questions = @(
                @{
                    Order = 1
                    Text = "Which keyword is used in Java to inherit from a superclass?"
                    A = "implements"; B = "inherits"; C = "extends"; D = "super"
                    Correct = "C"
                    Explanation = "Java uses 'extends' for class inheritance and 'implements' for interfaces."
                },
                @{
                    Order = 2
                    Text = "Can a Java class inherit from multiple concrete classes directly?"
                    A = "Yes, separated by commas"; B = "No, Java supports single class inheritance only"; C = "Yes, if they are abstract"; D = "Only in Java 17+"
                    Correct = "B"
                    Explanation = "Java prevents multiple class inheritance to eliminate ambiguity (diamond problem); classes can implement multiple interfaces instead."
                },
                @{
                    Order = 3
                    Text = "What does the 'final' keyword on a method mean in Java?"
                    A = "The method is executed last"; B = "The method cannot be overridden by subclasses"; C = "The method returns no value"; D = "The method cannot take parameters"
                    Correct = "B"
                    Explanation = "A final method cannot be overridden by subclasses."
                },
                @{
                    Order = 4
                    Text = "Which collection type does NOT allow duplicate elements?"
                    A = "ArrayList"; B = "LinkedList"; C = "HashSet"; D = "Vector"
                    Correct = "C"
                    Explanation = "Sets, such as HashSet, model the mathematical set abstraction and do not allow duplicates."
                },
                @{
                    Order = 5
                    Text = "What is encapsulation in Object-Oriented Programming?"
                    A = "Hiding internal data and requiring all interaction through public methods"; B = "Writing code in multiple files"; C = "Compiling into bytecode"; D = "Overloading method names"
                    Correct = "A"
                    Explanation = "Encapsulation bundles data and methods while keeping member fields private to safeguard integrity."
                }
            )
        },
        @{
            CourseId = 7
            Title = "Data Structures & Algorithmic Complexity Assessment"
            Description = "Challenge your algorithmic thinking: Big-O notation, trees, graphs, and search algorithms."
            PassingScore = 70
            Questions = @(
                @{
                    Order = 1
                    Text = "What is the average time complexity for searching an element in a balanced Binary Search Tree (BST)?"
                    A = "O(1)"; B = "O(log n)"; C = "O(n)"; D = "O(n log n)"
                    Correct = "B"
                    Explanation = "A balanced BST halves the search space at each step, yielding O(log n) search time."
                },
                @{
                    Order = 2
                    Text = "Which data structure operates on a Last-In, First-Out (LIFO) principle?"
                    A = "Queue"; B = "Stack"; C = "Heap"; D = "Linked List"
                    Correct = "B"
                    Explanation = "Stacks operate on LIFO principle (e.g. function call stack)."
                },
                @{
                    Order = 3
                    Text = "What is the worst-case time complexity of standard QuickSort?"
                    A = "O(n)"; B = "O(n log n)"; C = "O(n^2)"; D = "O(2^n)"
                    Correct = "C"
                    Explanation = "When the pivot is consistently the smallest or largest element, QuickSort degrades to O(n^2)."
                },
                @{
                    Order = 4
                    Text = "Which graph traversal algorithm uses a Queue data structure?"
                    A = "Breadth-First Search (BFS)"; B = "Depth-First Search (DFS)"; C = "Dijkstra only"; D = "Topological Sort"
                    Correct = "A"
                    Explanation = "BFS explores neighbor vertices level by level using a FIFO queue."
                },
                @{
                    Order = 5
                    Text = "What is the average lookup time in a properly sized Hash Table with minimal collisions?"
                    A = "O(1)"; B = "O(log n)"; C = "O(n)"; D = "O(n^2)"
                    Correct = "A"
                    Explanation = "Hash tables compute keys into indices directly, offering constant O(1) average lookup time."
                }
            )
        },
        @{
            CourseId = 8
            Title = "System Design & Distributed Scalability Assessment"
            Description = "Evaluate architecture decisions: caching, horizontal scaling, microservices, and CAP theorem."
            PassingScore = 70
            Questions = @(
                @{
                    Order = 1
                    Text = "According to the CAP theorem, which three guarantees cannot all be simultaneously achieved in a distributed system with network partitions?"
                    A = "Consistency, Availability, Partition Tolerance"; B = "Concurrency, Authenticity, Performance"; C = "Caching, Availability, Persistence"; D = "Compute, Access, Protection"
                    Correct = "A"
                    Explanation = "The CAP theorem states that a distributed data store can only guarantee two out of Consistency, Availability, and Partition tolerance."
                },
                @{
                    Order = 2
                    Text = "What is the primary benefit of horizontal scaling over vertical scaling?"
                    A = "It requires no networking"; B = "It allows scaling by adding more commodity machines rather than upgrading expensive hardware limits"; C = "It eliminates database bottlenecks automatically"; D = "It requires fewer servers"
                    Correct = "B"
                    Explanation = "Horizontal scaling scales out by adding more machines in parallel, overcoming hardware limits."
                },
                @{
                    Order = 3
                    Text = "Where is an in-memory cache (like Redis) typically placed to optimize database read latency?"
                    A = "Between the user and the CDN"; B = "Between the application servers and the persistent database"; C = "Inside the client's web browser"; D = "Behind the primary database storage disk"
                    Correct = "B"
                    Explanation = "Caches sit between app servers and relational databases to serve hot reads in sub-millisecond time."
                },
                @{
                    Order = 4
                    Text = "What is Database Sharding?"
                    A = "Creating database backups daily"; B = "Horizontal partitioning of database data across multiple physical database instances"; C = "Converting SQL databases to NoSQL"; D = "Normalizing tables into 3NF"
                    Correct = "B"
                    Explanation = "Sharding partitions large tables across multiple database servers based on a shard key."
                },
                @{
                    Order = 5
                    Text = "What is the primary role of a Reverse Proxy or Load Balancer in a distributed architecture?"
                    A = "To write database schemas"; B = "To distribute incoming network requests across a pool of backend servers and terminate SSL"; C = "To compile frontend JavaScript"; D = "To store user session cookies locally"
                    Correct = "B"
                    Explanation = "Load balancers distribute traffic across multiple app instances to maintain high availability and reliability."
                }
            )
        }
    )

    # Insert Quizzes and Questions
    $quizIds = @{}
    foreach ($q in $quizzes) {
        $insertQuizCmd = $conn.CreateCommand()
        $insertQuizCmd.CommandText = @"
            INSERT INTO Quizzes (Title, Description, PassingScorePercent, CourseId, CreatedDate)
            OUTPUT INSERTED.Id
            VALUES (@Title, @Desc, @Pass, @CourseId, @Date);
"@
        $insertQuizCmd.Parameters.AddWithValue("@Title", $q.Title) | Out-Null
        $insertQuizCmd.Parameters.AddWithValue("@Desc", $q.Description) | Out-Null
        $insertQuizCmd.Parameters.AddWithValue("@Pass", $q.PassingScore) | Out-Null
        $insertQuizCmd.Parameters.AddWithValue("@CourseId", $q.CourseId) | Out-Null
        $insertQuizCmd.Parameters.AddWithValue("@Date", [DateTime]::Now.AddDays(-15)) | Out-Null

        $newQuizId = [int]$insertQuizCmd.ExecuteScalar()
        $quizIds[$q.CourseId] = $newQuizId
        Write-Host "Created Quiz ID $newQuizId for Course $($q.CourseId): $($q.Title)"

        foreach ($question in $q.Questions) {
            $insertQCmd = $conn.CreateCommand()
            $insertQCmd.CommandText = @"
                INSERT INTO QuizQuestions (QuizId, OrderIndex, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption, Explanation)
                VALUES (@QuizId, @Order, @Text, @A, @B, @C, @D, @Correct, @Exp);
"@
            $insertQCmd.Parameters.AddWithValue("@QuizId", $newQuizId) | Out-Null
            $insertQCmd.Parameters.AddWithValue("@Order", $question.Order) | Out-Null
            $insertQCmd.Parameters.AddWithValue("@Text", $question.Text) | Out-Null
            $insertQCmd.Parameters.AddWithValue("@A", $question.A) | Out-Null
            $insertQCmd.Parameters.AddWithValue("@B", $question.B) | Out-Null
            $insertQCmd.Parameters.AddWithValue("@C", $question.C) | Out-Null
            $insertQCmd.Parameters.AddWithValue("@D", $question.D) | Out-Null
            $insertQCmd.Parameters.AddWithValue("@Correct", $question.Correct) | Out-Null
            $insertQCmd.Parameters.AddWithValue("@Exp", $question.Explanation) | Out-Null
            $insertQCmd.ExecuteNonQuery() | Out-Null
        }
    }

    # 3. Insert Enrollments for Users
    Write-Host "Seeding enrollments..."
    $enrollments = @(
        @{ UserId = $userId; CourseId = 1; Date = [DateTime]::Now.AddDays(-22) },
        @{ UserId = $userId; CourseId = 4; Date = [DateTime]::Now.AddDays(-14) },
        @{ UserId = $testId; CourseId = 1; Date = [DateTime]::Now.AddDays(-18) },
        @{ UserId = $testId; CourseId = 2; Date = [DateTime]::Now.AddDays(-10) },
        @{ UserId = $user1Id; CourseId = 3; Date = [DateTime]::Now.AddDays(-12) },
        @{ UserId = $beginnerId; CourseId = 1; Date = [DateTime]::Now.AddDays(-25) }
    )

    foreach ($e in $enrollments) {
        if (![string]::IsNullOrEmpty($e.UserId)) {
            $cmdE = $conn.CreateCommand()
            $cmdE.CommandText = "INSERT INTO UserCourses (UserId, CourseId, EnrollmentDate) VALUES (@U, @C, @D);"
            $cmdE.Parameters.AddWithValue("@U", $e.UserId) | Out-Null
            $cmdE.Parameters.AddWithValue("@C", $e.CourseId) | Out-Null
            $cmdE.Parameters.AddWithValue("@D", $e.Date) | Out-Null
            $cmdE.ExecuteNonQuery() | Out-Null
        }
    }

    # 4. Insert Day-Wise Lesson Progresses (Heatmap & Streaks)
    Write-Host "Seeding day-wise lesson progress..."
    $progressRecords = @(
        # user@gmail.com: active across last 7 days + earlier days
        @{ UserId = $userId; LessonId = 1; Date = [DateTime]::Now.AddDays(-20) },
        @{ UserId = $userId; LessonId = 2; Date = [DateTime]::Now.AddDays(-18) },
        @{ UserId = $userId; LessonId = 3; Date = [DateTime]::Now.AddDays(-14) },
        @{ UserId = $userId; LessonId = 4; Date = [DateTime]::Now.AddDays(-10) },
        @{ UserId = $userId; LessonId = 5; Date = [DateTime]::Now.AddDays(-7) },
        @{ UserId = $userId; LessonId = 16; Date = [DateTime]::Now.AddDays(-3) },
        @{ UserId = $userId; LessonId = 17; Date = [DateTime]::Now.AddDays(-2) },
        @{ UserId = $userId; LessonId = 18; Date = [DateTime]::Now.AddDays(-1) },
        @{ UserId = $userId; LessonId = 19; Date = [DateTime]::Now }, # today (streak!)

        # test@gmail.com
        @{ UserId = $testId; LessonId = 1; Date = [DateTime]::Now.AddDays(-15) },
        @{ UserId = $testId; LessonId = 2; Date = [DateTime]::Now.AddDays(-12) },
        @{ UserId = $testId; LessonId = 6; Date = [DateTime]::Now.AddDays(-8) },
        @{ UserId = $testId; LessonId = 7; Date = [DateTime]::Now.AddDays(-4) },
        @{ UserId = $testId; LessonId = 8; Date = [DateTime]::Now.AddDays(-1) },

        # user1@gmail.com
        @{ UserId = $user1Id; LessonId = 11; Date = [DateTime]::Now.AddDays(-10) },
        @{ UserId = $user1Id; LessonId = 12; Date = [DateTime]::Now.AddDays(-6) },
        @{ UserId = $user1Id; LessonId = 13; Date = [DateTime]::Now.AddDays(-2) },

        # beginner@gmail.com
        @{ UserId = $beginnerId; LessonId = 1; Date = [DateTime]::Now.AddDays(-22) },
        @{ UserId = $beginnerId; LessonId = 2; Date = [DateTime]::Now.AddDays(-19) },
        @{ UserId = $beginnerId; LessonId = 3; Date = [DateTime]::Now.AddDays(-14) }
    )

    foreach ($p in $progressRecords) {
        if (![string]::IsNullOrEmpty($p.UserId)) {
            $cmdP = $conn.CreateCommand()
            $cmdP.CommandText = "INSERT INTO LessonProgresses (UserId, LessonId, IsCompleted, CompletedDate) VALUES (@U, @L, 1, @D);"
            $cmdP.Parameters.AddWithValue("@U", $p.UserId) | Out-Null
            $cmdP.Parameters.AddWithValue("@L", $p.LessonId) | Out-Null
            $cmdP.Parameters.AddWithValue("@D", $p.Date) | Out-Null
            $cmdP.ExecuteNonQuery() | Out-Null
        }
    }

    # 5. Insert Quiz Attempts (For Leaderboard & Assessment History)
    Write-Host "Seeding quiz attempts for leaderboard..."
    $quiz1Id = $quizIds[1]
    $quiz2Id = $quizIds[2]
    $quiz3Id = $quizIds[3]
    $quiz4Id = $quizIds[4]

    $attempts = @(
        # user@gmail.com: 100% on Python, 80% on C#
        @{ QuizId = $quiz1Id; UserId = $userId; Total = 5; Correct = 5; Score = 100; Passed = 1; Date = [DateTime]::Now.AddDays(-7) },
        @{ QuizId = $quiz4Id; UserId = $userId; Total = 5; Correct = 4; Score = 80; Passed = 1; Date = [DateTime]::Now.AddDays(-1) },

        # test@gmail.com: 80% on Python, 60% on HTML
        @{ QuizId = $quiz1Id; UserId = $testId; Total = 5; Correct = 4; Score = 80; Passed = 1; Date = [DateTime]::Now.AddDays(-10) },
        @{ QuizId = $quiz2Id; UserId = $testId; Total = 5; Correct = 3; Score = 60; Passed = 0; Date = [DateTime]::Now.AddDays(-4) },

        # user1@gmail.com: 80% on JS
        @{ QuizId = $quiz3Id; UserId = $user1Id; Total = 5; Correct = 4; Score = 80; Passed = 1; Date = [DateTime]::Now.AddDays(-2) },

        # beginner@gmail.com: 60% on Python
        @{ QuizId = $quiz1Id; UserId = $beginnerId; Total = 5; Correct = 3; Score = 60; Passed = 0; Date = [DateTime]::Now.AddDays(-14) }
    )

    foreach ($a in $attempts) {
        if (![string]::IsNullOrEmpty($a.UserId) -and $a.QuizId -gt 0) {
            $cmdA = $conn.CreateCommand()
            $cmdA.CommandText = @"
                INSERT INTO QuizAttempts (QuizId, UserId, TotalQuestions, CorrectAnswers, ScorePercent, IsPassed, AttemptDate)
                VALUES (@Q, @U, @Total, @Correct, @Score, @Passed, @Date);
"@
            $cmdA.Parameters.AddWithValue("@Q", $a.QuizId) | Out-Null
            $cmdA.Parameters.AddWithValue("@U", $a.UserId) | Out-Null
            $cmdA.Parameters.AddWithValue("@Total", $a.Total) | Out-Null
            $cmdA.Parameters.AddWithValue("@Correct", $a.Correct) | Out-Null
            $cmdA.Parameters.AddWithValue("@Score", $a.Score) | Out-Null
            $cmdA.Parameters.AddWithValue("@Passed", $a.Passed) | Out-Null
            $cmdA.Parameters.AddWithValue("@Date", $a.Date) | Out-Null
            $cmdA.ExecuteNonQuery() | Out-Null
        }
    }

    Write-Host "✅ Seeding successfully completed!"
} catch {
    Write-Error "Error seeding database: $_"
} finally {
    $conn.Close()
}
