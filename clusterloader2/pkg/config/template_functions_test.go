/*
Copyright 2023 The Kubernetes Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package config

import (
	"testing"
)

func TestTemplateRandData(t *testing.T) {
	tests := []struct {
		length int
	}{
		{
			length: 1,
		},
		{
			length: 100,
		},
	}

	for _, tt := range tests {
		data := randData(tt.length)
		if tt.length != len(data) {
			t.Errorf("wanted: %d, got: %d", tt.length, len(data))
		}
	}
}

func TestDeterministicRandData(t *testing.T) {
	tests := []struct {
		seed   string
		length int
		want   string
	}{
		{
			seed:   "deployment-1",
			length: 1,
			want:   "y",
		},
		{
			seed:   "deployment-2",
			length: 1,
			want:   "H",
		},
		{
			seed:   "deployment-1",
			length: 100,
			want:   "y1f12IwpVhg4yxEpWsLGv9kPpJiegnVbxtkCUYYUfGZowLSPCwdPLc7p286exVl9M0RAR5i9DQsXDcbjQ3xzWjqf4jnWhFsP4fzg",
		},
		{
			seed:   "deployment-2",
			length: 100,
			want:   "H7Y8bVPxHn8LR1fvu9GeOLkheUbQsIx9EJkDp7SXQWKrOU2hPJ5RSvdKG8Ttzq8LeLdtYqZCYjSNegr1d339aGwOsFGtEbYUGWEG",
		},
		{
			seed:   "deployment-1",
			length: 10,
			want:   "y1f12IwpVh",
		},
		{
			seed:   "deployment-2",
			length: 10,
			want:   "H7Y8bVPxHn",
		},
	}

	for _, tt := range tests {
		data := deterministicRandData(tt.seed, tt.length)
		if data != tt.want {
			t.Errorf("wanted: %q, got: %q", tt.want, data)
		}
	}
}
