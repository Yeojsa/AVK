#define _POSIX_C_SOURCE 200809L
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAXN 1024
#define RUNS 5

#define STRASSEN_THRESHOLD 64

static int n;
static double a[MAXN][MAXN], b[MAXN][MAXN];
static double c[MAXN][MAXN], ref[MAXN][MAXN];

static double now(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

static void init(void) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) {
            a[i][j] = (double)rand() / RAND_MAX;
            b[i][j] = (double)rand() / RAND_MAX;
        }
}

/* Эталон: обычное умножение, нужно для проверки и как базовый случай. */
static void naive(double out[MAXN][MAXN]) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) {
            double s = 0;
            for (int k = 0; k < n; k++)
                s += a[i][k] * b[k][j];
            out[i][j] = s;
        }
}

static void mat_add(int k, const double *X, const double *Y, double *Z) {
    int total = k * k;
    for (int i = 0; i < total; i++)
        Z[i] = X[i] + Y[i];
}

static void mat_sub(int k, const double *X, const double *Y, double *Z) {
    int total = k * k;
    for (int i = 0; i < total; i++)
        Z[i] = X[i] - Y[i];
}

static void base_mul(int k, const double *X, const double *Y, double *Z) {
    for (int i = 0; i < k; i++)
        for (int j = 0; j < k; j++)
            Z[i * k + j] = 0.0;

    for (int i = 0; i < k; i++) {
        for (int p = 0; p < k; p++) {
            double r = X[i * k + p];
            for (int j = 0; j < k; j++) {
                Z[i * k + j] += r * Y[p * k + j];
            }
        }
    }
}

static void strassen_rec(int k, const double *X, const double *Y, double *Z) {
    if (k <= STRASSEN_THRESHOLD) {
        base_mul(k, X, Y, Z);
        return;
    }

    int m = k / 2;
    int m2 = m * m;

    double *A11 = (double *)malloc(m2 * sizeof(double));
    double *A12 = (double *)malloc(m2 * sizeof(double));
    double *A21 = (double *)malloc(m2 * sizeof(double));
    double *A22 = (double *)malloc(m2 * sizeof(double));

    double *B11 = (double *)malloc(m2 * sizeof(double));
    double *B12 = (double *)malloc(m2 * sizeof(double));
    double *B21 = (double *)malloc(m2 * sizeof(double));
    double *B22 = (double *)malloc(m2 * sizeof(double));

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < m; j++) {
            A11[i * m + j] = X[i * k + j];
            A12[i * m + j] = X[i * k + (j + m)];
            A21[i * m + j] = X[(i + m) * k + j];
            A22[i * m + j] = X[(i + m) * k + (j + m)];

            B11[i * m + j] = Y[i * k + j];
            B12[i * m + j] = Y[i * k + (j + m)];
            B21[i * m + j] = Y[(i + m) * k + j];
            B22[i * m + j] = Y[(i + m) * k + (j + m)];
        }
    }

    double *T1 = (double *)malloc(m2 * sizeof(double));
    double *T2 = (double *)malloc(m2 * sizeof(double));

    double *M1 = (double *)malloc(m2 * sizeof(double));
    double *M2 = (double *)malloc(m2 * sizeof(double));
    double *M3 = (double *)malloc(m2 * sizeof(double));
    double *M4 = (double *)malloc(m2 * sizeof(double));
    double *M5 = (double *)malloc(m2 * sizeof(double));
    double *M6 = (double *)malloc(m2 * sizeof(double));
    double *M7 = (double *)malloc(m2 * sizeof(double));

    mat_add(m, A11, A22, T1);
    mat_add(m, B11, B22, T2);
    strassen_rec(m, T1, T2, M1);

    mat_add(m, A21, A22, T1);
    strassen_rec(m, T1, B11, M2);

    mat_sub(m, B12, B22, T2);
    strassen_rec(m, A11, T2, M3);

    mat_sub(m, B21, B11, T2);
    strassen_rec(m, A22, T2, M4);

    mat_add(m, A11, A12, T1);
    strassen_rec(m, T1, B22, M5);

    mat_sub(m, A21, A11, T1);
    mat_add(m, B11, B12, T2);
    strassen_rec(m, T1, T2, M6);

    mat_sub(m, A12, A22, T1);
    mat_add(m, B21, B22, T2);
    strassen_rec(m, T1, T2, M7);

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < m; j++) {
            int idx = i * m + j;
            Z[i * k + j] = M1[idx] + M4[idx] - M5[idx] + M7[idx];
            Z[i * k + (j + m)] = M3[idx] + M5[idx];
            Z[(i + m) * k + j] = M2[idx] + M4[idx];
            Z[(i + m) * k + (j + m)] = M1[idx] - M2[idx] + M3[idx] + M6[idx];
        }
    }

    free(A11); free(A12); free(A21); free(A22);
    free(B11); free(B12); free(B21); free(B22);
    free(T1);  free(T2);
    free(M1);  free(M2);  free(M3);  free(M4);
    free(M5);  free(M6);  free(M7);
}

static void strassen(void) {
    double *A_flat = (double *)malloc(n * n * sizeof(double));
    double *B_flat = (double *)malloc(n * n * sizeof(double));
    double *C_flat = (double *)malloc(n * n * sizeof(double));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            A_flat[i * n + j] = a[i][j];
            B_flat[i * n + j] = b[i][j];
        }
    }

    strassen_rec(n, A_flat, B_flat, C_flat);

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            c[i][j] = C_flat[i * n + j];
        }
    }

    free(A_flat);
    free(B_flat);
    free(C_flat);
}

static double maxdiff(void) {
    double d = 0;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) {
            double x = fabs(c[i][j] - ref[i][j]);
            if (x > d) d = x;
        }
    return d;
}

int main(void) {
    const int sizes[] = {128, 256, 512, 1024};
    const int nsizes = (int)(sizeof sizes / sizeof sizes[0]);

    printf("n,method,run,seconds,gflops,maxdiff\n");
    for (int s = 0; s < nsizes; s++) {
        n = sizes[s];
        init();
        naive(ref);

        for (int m = 0; m < 2; m++) {
            const char *name = m ? "strassen" : "naive";
            for (int r = 1; r <= RUNS; r++) {
                for (int i = 0; i < n; i++)
                    for (int j = 0; j < n; j++)
                        c[i][j] = 0.0;

                double t0 = now();
                if (m) strassen();
                else   naive(c);
                double t = now() - t0;

                printf("%d,%s,%d,%.6f,%.3f,%.3e\n",
                       n, name, r, t, 2.0 * n * n * n / t / 1e9, maxdiff());
            }
        }
    }
    return 0;
}